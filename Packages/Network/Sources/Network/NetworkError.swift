//
//  NetworkError.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL

    public enum InvalidResponse: Error {
        /// For 404
        case notFound

        /// For 401
        case unauthorized

        /// For 400s other than 404
        case clientError

        /// For 500s
        case serverError

        case other
    }
}
