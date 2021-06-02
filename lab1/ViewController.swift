//
//  ViewController.swift
//  lab1
//
//  Created by Sasha Dmytrenko on 5/22/21.
//

import UIKit

enum FactorialError: LocalizedError {
    case lessZero
    case iterationLimit
    
    var errorDescription: String? {
        switch self {
        case .lessZero:
            return "passwed incorret number!"
        default:
            return "Iteration limit!"
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    @IBAction func goButtonTapped(_ sender: Any) {
        textField.resignFirstResponder()
        guard let value = textField.text,
              let number = Int(value) else {
            return
        }
        
        do {
            let (x, y) = try fermatFactor(of: number)
            
            let ac = UIAlertController(title: "Have an answer!", message: "\(x) and \(y)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Great!", style: .default))
            
            present(ac, animated: true)
        } catch {
            let ac = UIAlertController(title: "Oppps!", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Great!", style: .default))
            
            present(ac, animated: true)
        }
        

    }
    
    func fermatFactor(of n: Int) throws -> (Int, Int) {

        if n <= 0 {
            throw FactorialError.lessZero
        }
        
        if n.isMultiple(of: 2) {
            return (2, n / 2)
        }
        
        var a = Int(Double(n).squareRoot().rounded(.up))
        var b2 = a * a - n
        var iteration = 0
        while !b2.isSquare() {
            iteration += 1
            if iteration >= 100 {
                throw FactorialError.iterationLimit
            }
            a = a + 1
            b2 = a * a - n
        }
        let x = a - Int(Double(b2).squareRoot().rounded(.up))
        return (x, n / x)
        
    }

}

extension Int {

    func isSquare() -> Bool {
        let root = Int(Double(self).squareRoot())
        return root * root == self
    }
    
}
