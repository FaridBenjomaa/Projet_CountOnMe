//
//  SubstractionTestCase.swift
//  CountOnMeTests
//
//  Created by Farid Benjomaa on 08/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe


class SubstractionTestCase: XCTestCase {

    func testGivenInstanceOfSubstraction_WhenIsCreated_ThenItexists(){
        let substraction  = Substraction()
        
        XCTAssertNotNil(substraction)
    }

}
