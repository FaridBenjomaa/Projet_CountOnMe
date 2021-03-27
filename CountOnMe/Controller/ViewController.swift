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
        var operationsToReduce = elements
   
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            while operationsToReduce.count >= 4 {
               
                
                var result: Int = 0
                var resultDivide: Float = 0
                for (index,operators) in elements.enumerated(){
                    print(index, operators)
                    if operators == "x"{
                        let left = Int(operationsToReduce[index-1])!
                        let right = Int(operationsToReduce[index+1])!
                        result = calcul.multiplication(left, right)
                        operationsToReduce.remove(at: index+1)
                        operationsToReduce.remove(at: index)
                        operationsToReduce.remove(at: index-1)
                        operationsToReduce.insert("\(result)", at: index-1)
                    }
                    if operators == "÷"{
                        let left = Int(operationsToReduce[index-1])!
                        let right = Int(operationsToReduce[index+1])!
                        resultDivide = calcul.division(left, right)
                        operationsToReduce.remove(at: index+1)
                        operationsToReduce.remove(at: index)
                        operationsToReduce.remove(at: index-1)
                        let result = Int(resultDivide)
                        operationsToReduce.insert("\(result)", at: index-1)
                       
                        
                    }
                   
                }
                 
            }
            
      
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
          
                var result: Int = 0
                var resultDivide: Float = 0
                switch operand {
                    case "+": result = calcul.addition(left,right)
                    case "-": result = calcul.substraction(left,right)
                    case "x": result = calcul.multiplication(left, right)
                    case "÷": resultDivide = calcul.division(left, right)
                    default: fatalError("Unknown operator !")
    
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            if operand == "÷"{
                operationsToReduce.insert("\(resultDivide)", at: 0)
            }else{
                operationsToReduce.insert("\(result)", at: 0)
            }
            
            
        }
    
        
        
        
        
        
        textView.text.append(" = \(operationsToReduce.first!)")
    }

}

