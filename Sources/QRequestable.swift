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
    var baseURL: String { get }
    var path: String { get }
    var query: [String: Any]? { get }
    var method: QHTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
    func request() -> URLRequest
}

public extension QRequestable {
    
    func request() -> URLRequest {
        var comps = URLComponents(string: baseURL)!
        comps.path = path
        comps.queryItems = query?.queryItems
        
        var req = URLRequest(url: comps.url!)
        req.allHTTPHeaderFields = headers
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

public extension Dictionary where Key == String {
    
    var queryItems: [URLQueryItem] {
        return self.flatMap { recQuery(key: $0.key, value: $0.value) }
    }
    
    private func recQuery(key: String, value: Any) -> [URLQueryItem] {
        if let v = value as? [Any] {
            return v.flatMap{ recQuery(key: key + "[]", value: $0) }
        } else {
            return [URLQueryItem(name: key, value: (value as? AnyObject)?.description)]
        }
    }
}
