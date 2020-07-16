//
//  Word_ScrambleTests.swift
//  Word ScrambleTests
//
//  Created by Clark Lindsay on 6/29/20.
//  Copyright © 2020 Clark Lindsay. All rights reserved.
//

import XCTest
@testable import Word_Scramble

class Word_ScrambleTests: XCTestCase {

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_banana_isEnglish() throws {
        let content = ContentView()
        XCTAssert(content.isEnglis(word: "banana") == true)
    }
    
    func test_banan_isNotEnglish() throws {
        let content = ContentView()
        XCTAssert(content.isEnglis(word: "banan") == false)
    }
    
    func test_horse_isLongEnough() throws {
        let content = ContentView()
        XCTAssert(content.isLongerThan(word: "horse") == true)
    }
    
    func test_hor_isNotLongEnough() throws {
        let content = ContentView()
        XCTAssert(content.isLongerThan(word: "hor") == false)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
