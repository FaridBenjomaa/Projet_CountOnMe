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
        let operationsToDoFirst = elements
   
        while operations.count > 1 {
            var left = Double(operations[0])!

            var right = Double(operations[2])!
            var result: String = "0"
            
            if operations.count > 3{
                
                for (index, elements) in operationsToDoFirst.enumerated() {
                    
                    func oprerationFirst(){
                        
                        left = Double(operationsToDoFirst[index-1])!
                        right = Double(operationsToDoFirst[index+1])!
                        
                        if  elements == "x"{
                            result = "\(calcul.makeMultiplication(left, right))"
                        }else if elements == "÷"{
                            result = "\(calcul.makeDivision(left, right))"
                        }
                        
                        let newResult = result
                        operations.remove(at: index)
                        operations.insert("\(newResult)", at: index)
                        operations.remove(at: index+1)
                        operations.remove(at: index-1)
                    }
                    
                    if elements == "x" || elements == "÷" {
                        oprerationFirst()
                    }
            }
        }
            left = Double(operations[0])!
            let operand = operations[1]
            right = Double(operations[2])!
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
        textView.text.append(" = \(operations.first!)")
    }

}

