//
//  RequestManagerMock.swift
//  
//
//  Created by Andrey Yakovlev on 09.10.2022.
//

import Foundation
import Network

final class RequestManagerMock: RequestManager {

    func perform(request: Request, authToken: String?) async throws -> Data {
        guard let url = Bundle.module.url(forResource: request.path, withExtension: "json", subdirectory: "JSON"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Missing file: \(request.path).json")
        }

        return data
    }

}
