//
//  TestCaseFilterViewModel.swift
//  MeowTests
//
//  Created by Leong, Choi Chee on 9/2/21.
//

import XCTest
@testable import Meow

class TestCaseFilterViewModel: XCTestCase {

    var filterViewModel = FilterViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testPlusQuestion() {
        let numA: Int = 10
        let numB: Int = 9
        let op: Int = 0
    
        let (question, answer) = self.filterViewModel.getRamdomQuestion(numA: numA, numB: numB, op: op)
        
        // expected answer must be equal
        XCTAssertEqual(question, "10 + 9 =", "Expected answer must be equal")
        
        // expected answer must be equal
        XCTAssertEqual(answer, 19, "Expected answer must be equal")
    }
    
    func testDiveQuestion() {
        let numA: Int = 9
        let numB: Int = 9
        let op: Int = 4
    
        let (question, answer) = self.filterViewModel.getRamdomQuestion(numA: numA, numB: numB, op: op)
        
        // expected answer must be equal
        XCTAssertEqual(question, "9 ÷ 9 =", "Expected question must be equal")
        
        // expected answer must be equal
        XCTAssertEqual(answer, 1, "Expected answer must be equal")
    }

}
