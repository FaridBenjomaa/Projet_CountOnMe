//
//  AdditionTestCase.swift
//  CountOnMeTests
//
//  Created by Farid Benjomaa on 08/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class AdditionTestCase: XCTestCase {

    
    func testGivenInstanceOfAddidtion_WhenIsCreated_ThenItexists(){
        let addition = Addition()
 
        XCTAssertNotNil(addition)
    }

}
