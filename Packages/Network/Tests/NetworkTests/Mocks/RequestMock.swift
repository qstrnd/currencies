//
//  RequestMock.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation
import Network

struct RequestMock: Request {
    let host = ""
    var path = ""
    let requestType: RequestType = .get
}
