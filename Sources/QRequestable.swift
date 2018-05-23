//
//  QRequestable.swift
//  QNetworking
//
//  Created by Arif De Sousa on 22/03/2018.
//  Copyright © 2018 Quadram. All rights reserved.
//

import Foundation

public enum QHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public protocol QRequestable {
    var url: String { get }
    var path: String { get }
    var method: QHTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    func request() -> URLRequest
}

public extension QRequestable {
    
    func request() -> URLRequest {
        let urlStr = url + path + (query?.queryString ?? "")
        var req = URLRequest(url: URL(string: urlStr)!)
        
        headers?.forEach {
            req.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        req.httpMethod = method.rawValue
        req.httpBody = body
        return req
    }
    
    func printCURL() -> Self {
        print(self.cURL)
        return self
    }
    
    var cURL: String {
        let req = request()
        guard let url = req.url else { return "" }
        var baseCommand = "curl \(url.absoluteString)"
        
        if req.httpMethod == "HEAD" {
            baseCommand += " --head"
        }
        
        var command = [baseCommand]
        
        if let method = req.httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }
        
        if let headers = req.allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }
        
        if let data = req.httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }
        
        return command.joined(separator: " \\\n\t")
    }
    
}

extension Dictionary where Key == String {
    var queryString: String {
        return "?" + self.map{
            return queryKV(key: $0.key, value: $0.value)
            }
            .joined(separator: "&")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    private func queryKV(key: String, value: Any) -> String {
        if let v = value as? [Any] {
            return v.map{
                queryKV(key: key + "[]", value: $0)
                }.joined(separator: "&")
        } else {
            return key + "=" + (value as AnyObject).description
        }
    }
}
