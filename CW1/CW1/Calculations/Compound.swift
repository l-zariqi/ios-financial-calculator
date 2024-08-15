//
//  Compound.swift
//  CW1
//
//  Created by Lind Zariqi on 23/03/2022.
//

import Foundation

// Calculations for Compound Savings

class Compound {
    static func CalculatePrincipleAmount(interestRate: Double, futureValue: Double, numberOfPayments: Double) -> Double {
        var calculation = 1 + (interestRate / 100 / 12)
        calculation = pow(calculation, 12 * numberOfPayments)
        calculation = futureValue / calculation
        return calculation
    }
    
    static func CalculateFutureValue(interestRate: Double, principleAmount: Double, numberOfPayments: Double) -> Double {
        var calculation = 1 + (interestRate / 100 / 12)
        calculation = pow(calculation, 12 * numberOfPayments)
        calculation = principleAmount * calculation
        return calculation
    }
    
    static func CalculateInterestRate(futureValue: Double, principleAmount: Double, numberOfPayments: Double) -> Double {
        var calculation = futureValue / principleAmount
        calculation = pow(calculation, ( 1 / ( 12 * numberOfPayments ) ) )
        calculation = (calculation - 1) * 12
        return calculation * 100
    }
    
    static func CalculateNumberOfPayments(interestRate: Double, futureValue: Double, principleAmount: Double) -> Double {
        let top = log(futureValue / principleAmount)
        let bottom = 12 * log(1 + (interestRate / 100 / 12))
        let calculation: Double = top / bottom
        return calculation
    }
}
