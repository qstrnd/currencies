//
//  Request.swift
//  
//
//  Created by Andrey Yakovlev on 08.10.2022.
//

import Foundation

public enum RequestType: String {
    case get
    case post

    var value: String {
        rawValue.uppercased()
    }
}

public protocol Request {
    var host: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
    var queryParameters: [String: String] { get }
    var requestType: RequestType { get }
    var addAuthorizationToken: Bool { get }
}

public extension Request {
    var headers: [String: String] { [:] }
    var parameters: [String: String] { [:] }
    var queryParameters: [String: String] { [:] }
    var addAuthorizationToken: Bool { false }
}
