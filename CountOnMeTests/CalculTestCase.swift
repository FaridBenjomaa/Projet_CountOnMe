//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Farid Benjomaa on 10/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculTestCase: XCTestCase {
    var calcul = Calcul()
    
    func testGivenAddition_When_Then() {
        let result =  calcul.addition(2, 3)
        
        XCTAssertEqual(result, 5)
    }
    func testGivenSoustraction_When_Then() {
        let result =  calcul.substraction(3, 1)
        
        XCTAssertEqual(result, 2)
    }
    func testGivenMultiplication_When_Then() {
        let result =  calcul.multiplication(2, 3)
        
        XCTAssertEqual(result, 6)
    }
    func testGivenDivision_When_Then() {
        let result =  calcul.division(10, 2)
        
        XCTAssertEqual(result, 5)
    }

}
