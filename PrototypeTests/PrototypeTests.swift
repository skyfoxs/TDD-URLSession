//
//  PrototypeTests.swift
//  PrototypeTests
//
//  Created by Supakit Thanadittagorn on 10/11/2559 BE.
//  Copyright © 2559 Supakit Thanadittagorn. All rights reserved.
//

import XCTest
@testable import Prototype

class AccountAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testList_shouldRetrieveContentWithDataTask() {
        let accountAPI = AccountAPI()
        accountAPI.session = MockURLSession()

        accountAPI.list(for: "Rwenderlich")

        XCTAssertTrue((accountAPI.session as! MockURLSession).dataTaskToHaveBeenCalled)
        XCTAssertTrue((accountAPI.session as! MockURLSession).task.taskResumeToHaveBeenCalled)

    }

    func testList_shouldRetrieveContentWithCorrectURL() {
        let accountAPI = AccountAPI()
        accountAPI.session = MockURLSession()

        accountAPI.list(for: "Rwenderlich")

        XCTAssertEqual((accountAPI.session as! MockURLSession).testUrl, "https://twitter.com/rwenderlich/following")
    }

    func testList_shouldCallFinishOnDelegateWhenCanGetAccountList(){
        let accountAPI = AccountAPI()
        let controller = MyController()
        accountAPI.session = MockURLSession()
        accountAPI.delegate = controller

        accountAPI.list(for: "Rwenderlich")

        XCTAssertTrue(controller.didFinishLoadingToHaveBeenCalled)
    }

    // MARK: - Mock dependencies

    class MyController: AccountAPIDelegate {
        var didFinishLoadingToHaveBeenCalled = false

        func didFinishLoading(accounts: [Account]) {
            didFinishLoadingToHaveBeenCalled = true
        }
    }

    class MockURLSession: URLSession {
        var dataTaskToHaveBeenCalled = false
        var task = MockURLSessionDataTask()
        var testUrl = ""

        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            dataTaskToHaveBeenCalled = true
            testUrl = url.absoluteString
            task.handler = completionHandler

            return task
        }
    }

    class MockURLSessionDataTask: URLSessionDataTask {
        typealias Handler = (Data?, URLResponse?, Error?) -> Void
        var taskResumeToHaveBeenCalled = false
        var handler: Handler?

        override func resume() {
            taskResumeToHaveBeenCalled = true
            handler?(Data(), URLResponse(), nil)
        }
    }
}
