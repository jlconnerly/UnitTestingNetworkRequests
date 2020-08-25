//
//  MockURLSession.swift
//  Testing Network Requests (with Mocks)Tests
//
//  Created by Jake Connerly on 8/25/20.
//  Copyright © 2020 jake connerly. All rights reserved.
//

import Foundation
@testable import Testing_Network_Requests__with_Mocks_

/*
 This is a spy class that allows us to inject a mock Datatask allowing us to test what we
 are passing to the request without actually having the Data come back causing a slow down.
 The only problem with this is, we do not test how we are parsing or handling the data that comes back.
 */
class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return URLSessionDataTask()
    }
    
    
}
