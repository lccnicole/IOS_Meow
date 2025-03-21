//
//  Math.swift
//  Meow
//
//  Created by Leong, Choi Chee on 8/2/21.
//

import Foundation

struct FilterViewModel {
   
    func getRamdomQuestion(numA:Int, numB:Int, op: Int) -> (question:String, answer:Int) {
        var ans: Int = 0
        let question = "\(numA) \(op == 0 ? "+" : op == 1 ? "-" : op == 2 ? "x" : "÷") \(numB) ="
        ans = op == 0 ? numA + numB : op == 1 ? numA - numB : op == 2 ? numA * numB : numA / numB
        
        let q = "\(numA)\(op == 0 ? "+" : op == 1 ? "-" : op == 2 ? "*" : "/")\(numB)"
        
        ///this is another way to do calculation
        let expn = NSExpression(format:q)
        let answer = (expn.expressionValue(with: nil, context: nil)) as! Int
        
        print("question: \(question) Answer: \(answer)");
        return (question, ans)
    }
}
