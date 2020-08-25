//
//  Testing_Network_Requests__with_Mocks_Tests.swift
//  Testing Network Requests (with Mocks)Tests
//
//  Created by Jake Connerly on 8/25/20.
//  Copyright © 2020 jake connerly. All rights reserved.
//

import XCTest
@testable import Testing_Network_Requests__with_Mocks_

class Testing_Network_Requests__with_Mocks_Tests: XCTestCase {
    
    private var sut: ViewController!
    private var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        mockURLSession = MockURLSession()
        sut.session = mockURLSession
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        mockURLSession = nil
    }

    func test_searchForReadyPlayerOneBook() throws {
        tap(sut.sendRequestButton)

        XCTAssertEqual(mockURLSession.dataTaskCallCount, 1, "call count")
        XCTAssertEqual( mockURLSession.dataTaskArgsRequest.first, URLRequest(url: URL(string: "https://itunes.apple.com/search?media=ebook&term=Ready%20player%20one")!), "request")

    }
}
