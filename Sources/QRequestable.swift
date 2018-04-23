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
