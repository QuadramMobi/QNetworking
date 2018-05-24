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
    let status: Int? // Se esta pensando en no devolver statusCode por JSON sino por cabecera
    let message: String
    let data: T! //Un QResponse puede ser correcto e igual devolver null por 'data'
    let paginator: Paginator?
}

struct QResponseError: Codable {
    let code: Int
    let message: String
}

public struct Paginator: Decodable {
    //    let previous: Int?
    //    let current: Int
    let next: Int!
}
