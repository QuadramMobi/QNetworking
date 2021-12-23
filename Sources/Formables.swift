//
//  FormData.swift
//  QNetworking
//
//  Created by Arif De Sousa on 24/05/2018.
//  Copyright © 2018 Quadram. All rights reserved.
//

import Foundation

public protocol Formable {
    func formString() -> Data
}

public struct FormField: Formable {
    let name: String
    let value: String
    
    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    public func formString() -> Data {
        var body = ""
        body += "Content-Disposition:form-data; name=\"\(name)\""
        body += "\r\n\r\n\(value)\r\n"
        return body.data(using: .utf8)!
    }
}

public struct FormFile: Formable {
    let name: String
    let data: Data
    let type: String
    let fileName: String
    
    public init(name: String, data: Data, type: String, fileName: String){
        self.name = name
        self.data = data
        self.type = type
        self.fileName = fileName
    }
    
    public func formString() -> Data {
        var body = ""
        body += "Content-Disposition:form-data; name=\"\(name)\""
        body += "; filename=\"\(fileName)\"\r\n"
        body += "Content-Type: \(type)\r\n\r\n"
        return body.data(using: .utf8)! + data + "\r\n".data(using: .utf8)!
    }
}
