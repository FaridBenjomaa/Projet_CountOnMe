//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var calcul = Calcul()
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        textView.text.append(numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(calcul.addition)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(calcul.substraction)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if canAddOperator {
            textView.text.append(calcul.multiplication)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        
        if canAddOperator {
            textView.text.append(calcul.division)
        } else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        // Create local copy of operations
        var operations = elements
        let operationsToMultiply = elements
   
        while operations.count > 1 {
            var left = Double(operations[0])!
           
            var right = Double(operations[2])!
            var result: String = "0"
            
            if operations.count > 3{

                for (index, elements) in operationsToMultiply.enumerated() {
                    print(index, elements)
                    if index == 3 && elements == "x"{
                        left = Double(operationsToMultiply[2])!
                        right = Double(operationsToMultiply[4])!
                        result = "\(calcul.makeMultiplication(left, right))"
                        operations.remove(at: 2)
                        operations.insert("\(result)", at: 2)
                        operations.remove(at: 4)
                        operations.remove(at: 3)
                    }else if index == 1 && elements == "x"{
                        left = Double(operationsToMultiply[0])!
                        right = Double(operationsToMultiply[2])!
                        result = "\(calcul.makeMultiplication(left, right))"
                        operations.remove(at: 0)
                        operations.insert("\(result)", at: 0)
                        operations.remove(at: 2)
                        operations.remove(at: 1)
                    }else if index == 5 && elements == "x"{
                        left = Double(operationsToMultiply[4])!
                        right = Double(operationsToMultiply[6])!
                        result = "\(calcul.makeMultiplication(left, right))"
                        
                        operations = Array(operations.dropLast(3))
                        operations.append("\(result)")
                }
            }
                
        }
            left = Double(operations[0])!
            let operand = operations[1]
            right = Double(operations[2])!
            print(operations)
            switch operand {
                case "+": result = "\(calcul.makeAddition(left, right))"
                case "-": result = "\(calcul.makeSubstraction(left, right))"
                case "x": result = "\(calcul.makeMultiplication(left, right))"
                case "÷": result = "\(calcul.makeDivision(left, right))"
                default: fatalError("Unknown operator !")
            }
            operations = Array(operations.dropFirst(3))
            if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                result = "\(Int(Double(result)!))"
            }
            operations.insert("\(result)", at: 0)
        }
        
        
        
        
        /*if elements.count >= 5{
            for (index,operation) in operations.enumerated(){
                print(index, operation)
                print(operations)
                if operation == "x"{
                    let number1 = Double(operations[index-1])
                    let number2 = Double(operations[index+1])
                    let result = calcul.makeMultiplication(number1!, number2!)
                    operationsToMultiply.append("\(result)")
                    print(operations)
                    print(operationsToMultiply)
                }else if operation == "+" || operation == "-" || operation == "/"{
                    let add = operations[index]
                    operationsToMultiply.append("\(add)")
                    print(operationsToMultiply)
                }
            }
        }*/
        
        // Iterate over operations while an operand still here
       /* while operations.count > 1 {
            if operations.count >= 4{
                
                var result: Double = 0
                var left = Double(operations[0])!
                var right = Double(operations[2])!
                
                for (index,operators) in elements.enumerated(){
                    print(index, operators)
                    if operators == "x"{
                            left = Double(operations[index-1])!
                            right = Double(operations[index+1])!
                            operations.remove(at: index+1)
                            operations.remove(at: index)
                            operations.remove(at: index-1)
                            result = calcul.makeMultiplication(left, right)
                            operations.insert("\(result)", at: index-1)
                            
                        }
                        print(operations)
                    }
                
            }
            
            let left = Double(operations[0])!
            let operand = operations[1]
            let right = Double(operations[2])!
 
                var result: String = "0"
                switch operand {
                    case "+": result = "\(calcul.makeAddition(left, right))"
                    case "-": result = "\(calcul.makeSubstraction(left, right))"
                    case "x": result = "\(calcul.makeMultiplication(left, right))"
                    case "÷": result = "\(calcul.makeDivision(left, right))"
                    default: fatalError("Unknown operator !")
            }
            operations = Array(operations.dropFirst(3))
            if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                result = "\(Int(Double(result)!))"
            }
            operations.insert("\(result)", at: 0)
        }*/
        textView.text.append(" = \(operations.first!)")
    }

}

