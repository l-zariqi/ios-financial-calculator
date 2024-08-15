//
//  Savings.swift
//  CW1
//
//  Created by Lind Zariqi on 17/03/2022.
//

import Foundation

// Calculations for Savings

class Savings {
    static func futureValueEnd(principleAmount: Double, monthlyPayment: Double, interestRate: Double, numberOfPayments: Double) -> Double {
        if interestRate == 0 {
            return principleAmount + (numberOfPayments * monthlyPayment * 12)
        }
        let interest = interestRate / 100
        var a = 1 + (interest / 12)
        a = pow(a, 12 * numberOfPayments)
        a = principleAmount * a
        var b = 1 + (interest / 12)
        b = pow(b, 12 * numberOfPayments)
        b = b - 1
        b = b / (interest / 12)
        b = monthlyPayment * b
        let calculation = a + b
        return calculation
    }
    
    static func futureValueBegin(principleAmount: Double, monthlyPayment: Double, interestRate: Double, numberOfPayments: Double) -> Double {
        if interestRate == 0 {
            return principleAmount + (numberOfPayments * monthlyPayment * 12)
        }
        let interest = interestRate / 100
        var a = 1 + (interestRate / 12)
        a = pow(a, 12 * numberOfPayments)
        a = principleAmount * a
        var b = 1 + (interest / 12)
        b = pow(b, 12 * numberOfPayments)
        b = b - 1
        b = b / (interest / 12)
        b = monthlyPayment * b
        b = b * (1 + (interest / 12))
        let calculation = a + b
        return calculation
    }
    
    static func monthlyPaymentEnd(principleAmount: Double, futureAmount: Double, interestRate: Double, numberOfPayments: Double) -> Double {
        if interestRate == 0 {
            return (futureAmount - principleAmount) / numberOfPayments / 12
        }
        let interest = interestRate / 100
        var a = 1 + (interest / 12)
        a = pow(a, 12 * numberOfPayments)
        a = principleAmount * a
        var calculation = 1 + (interest / 12)
        calculation = pow(calculation, 12 * numberOfPayments)
        calculation = calculation - 1
        calculation = calculation / (interest / 12)
        calculation = (futureAmount - a) / calculation
        return calculation
    }
    
    static func monthlyPaymentBegin(principleAmount: Double, futureAmount: Double, interestRate: Double, numberOfPayments: Double) -> Double {
        if interestRate == 0 {
            return (futureAmount - principleAmount) / numberOfPayments / 12
        }
        let interest = interestRate / 100
        var a = 1 + (interest / 12)
        a = pow(a , 12 * numberOfPayments)
        a = principleAmount * a
        var calculation = 1 + (interest / 12)
        calculation = pow(calculation, 12 * numberOfPayments)
        calculation = calculation - 1
        calculation = calculation / (interest / 12)
        calculation = calculation * (1 + (interest / 12))
        calculation = (futureAmount - a) / calculation
        return calculation
    }
    
    static func numberOfPaymentsEnd(principleAmount: Double, futureAmount: Double, interestRate: Double, monthlyPayment: Double) -> Double {
        if interestRate == 0 {
            return (futureAmount - principleAmount) / monthlyPayment / 12
        }
        let interest = interestRate / 100
        var a = futureAmount * (interest / 12)
        a = a + monthlyPayment
        var b = principleAmount * (interest / 12)
        b = b + monthlyPayment
        let c = log(a / b)
        var d = 1 + (interest / 12)
        d = 12 * log(d)
        d = 1 / d
        let calculation = c * d
        return calculation
    }
    
    static func numberOfPaymentsBegin(principleAmount: Double, futureAmount: Double, interestRate: Double, monthlyPayment: Double) -> Double {
        if interestRate == 0 {
            return (futureAmount - principleAmount) / monthlyPayment / 12
        }
        let interest = interestRate / 100
        var a = monthlyPayment / (interest / 12)
        a = futureAmount + a + monthlyPayment
        var b = monthlyPayment / (interest / 12)
        b = principleAmount + b + monthlyPayment
        let c = log (a / b)
        var d = 1 + (interest / 12)
        d = 12 * log(d)
        let calculation = c / d
        return calculation
    }
}
