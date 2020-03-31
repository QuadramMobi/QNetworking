//
//  QResponse.swift
//  QNetworking
//
//  Created by Arif De Sousa on 16/04/2018.
//  Copyright © 2018 Quadram. All rights reserved.
//

import Foundation

public enum ResponseError: LocalizedError {
    case customError(msg: String, code: Int)
    
    public var errorDescription: String? {
        switch self {
        case let .customError(msg, code): return "\(msg) (\(code))"
        }
    }
}

public struct QResponse<T: Decodable>: Decodable {
    public var status: Int? // Se esta pensando en no devolver statusCode por JSON sino por cabecera
    public let message: String?
    public let data: T? //Un QResponse puede ser correcto e igual devolver null por 'data'
    public let paginator: Paginator?
}

struct QResponseError: Codable {
    public let code: Int
    public let message: String
}

public struct Paginator: Decodable {
    public let prev: Int?
    public let next: Int!
    public let current: Int?
    public let total: Int?
    public let limit: Int?
}
