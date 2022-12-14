//
//  RequestMock.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation
import Network

struct RequestMock: Request {
    var host = ""
    var path = ""
    var requestType: RequestType = .get
    var addAuthorizationToken: Bool = false
}
