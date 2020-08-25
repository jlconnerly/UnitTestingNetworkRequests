//
//  MockURLSession.swift
//  Testing Network Requests (with Mocks)Tests
//
//  Created by Jake Connerly on 8/25/20.
//  Copyright © 2020 jake connerly. All rights reserved.
//

import Foundation
@testable import Testing_Network_Requests__with_Mocks_

class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return URLSessionDataTask()
    }
    
    
}
