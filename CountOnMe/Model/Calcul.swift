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
    var division = " / "
    
    func addition(_ a: Int, _ b: Int) ->Int{
        let result = a + b
        return result
    }
    
    func substraction(_ a: Int, _ b: Int) ->Int{
        let result = a - b
        return result
    }
   
    func multiplication(_ a: Int, _ b: Int) ->Int{
        let result = a * b
        return result
    }
    
    func division(_ a: Int, _ b: Int) ->Float{
        let result = Float(a) / Float(b)
        return result
    }
    
    
}
