//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Farid Benjomaa on 10/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    let calcul = Calcul()
    var controller:ViewController!
    
    func testGiven5_WhenAdditionBy5_ThenResultShouldBe10(){
        let result = calcul.makeAddition(5, 5)
        
        XCTAssert(result == 10)
    }
    
    func testGiven5_WhenSubstractBy5_ThenResultShouldBe0(){
        let result = calcul.makeSubstraction(5, 5)
        
        XCTAssert(result == 0)
    }
    
    func testGiven5_WhenMultiplyBy5_ThenResultShouldBe25(){
        let result = calcul.makeMultiplication(5, 5)
        
        XCTAssert(result == 25)
    }
    
    func testGiven20_WhenDiviseBy4_ThenResultShouldBe5(){
        let result = calcul.makeDivision(20, 4)
        
        XCTAssert(result == 5)
    }
    
    func testGiven2_WhenAdd2multiplyBy4_ThenResultShouldBe10(){
        var operation = ["2", "+", "2", "x", "4"]
        
        operation = calcul.oprerationFirst(array: operation)
        operation = calcul.operationThreeElement(array: operation)

        XCTAssert(operation == ["10"])
    }
    
    func testGivenDoubleMultiplication_WhenMultiply2By4and2by5_ThenResultShouldBe18(){
        var operation = ["2", "x", "4", "+", "2", "x", "5"]
        
        while operation.count > 3{
            operation = calcul.oprerationFirst(array: operation)
        }
        operation = calcul.operationThreeElement(array: operation)

        XCTAssert(operation == ["18"])
    }
    
    
  
}
