//
//  Calcul.swift
//  CountOnMe
//
//  Created by Farid Benjomaa on 09/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calcul{
    
    var addition = " + "
    var substraction = " - "
    var multiplication = " x "
    var division = " ÷ "
    
    func makeAddition(_ a: Double, _ b: Double) ->Double{
        let result = a + b
        return result
    }
    
    func makeSubstraction(_ a: Double, _ b: Double) ->Double{
        let result = a - b
        return result
    }
   
    func makeMultiplication(_ a: Double, _ b: Double) ->Double{
        let result = a * b
        return result
    }
    
    func makeDivision(_ a: Double, _ b: Double) ->Double{
        let result = Double(a) / Double(b)
        return result
    }
    
    func operationThreeElement(array: Array<String>) -> Array<String>{
        let left = array[0]
        let operand = array[1]
        let right = array [2]
        
        return array
    }
    
}
