//
//  Mortgage.swift
//  CW1
//
//  Created by Lind Zariqi on 17/03/2022.
//

import Foundation

// Calculations for Mortgage/Loans

class Mortgage {
    static func monthlyPayment(principleAmount: Double, interestRate: Double, numberOfPayments: Double) -> Double{
        if (interestRate == 0) {return principleAmount / numberOfPayments / 12}
        let part = interestRate / 100 / 12
        var top = pow(1 + part, 12 * numberOfPayments)
        top = principleAmount * part * top
        var bottom = pow(1 + part, 12 * numberOfPayments)
        bottom = bottom - 1
        let calculation = top / bottom
        return calculation
    }
    
    static func numberOfPayments(principleAmount: Double, interestRate: Double, monthlyPayment: Double) -> Double{
        if (interestRate == 0) {return principleAmount / monthlyPayment / 12}
        let part = interestRate / 100
        var top = principleAmount * part
        top = top - (12 * monthlyPayment)
        top = (-12 * monthlyPayment) / top
        top = log(top)
        var bottom = (part + 12) / 12
        bottom = 12 * log(bottom)
        let calculation = top / bottom
        return calculation
    }
    
    static func initialValue(monthlyPayment: Double, interestRate: Double, numberOfPayments: Double) -> Double{
        if (interestRate == 0) {return monthlyPayment * numberOfPayments * 12}
        let part = interestRate / 100 / 12
        var top = pow(1 + part, 12 * numberOfPayments)
        top = top - 1
        top = monthlyPayment * top
        var bottom = pow(1 + part, 12 * numberOfPayments)
        bottom = part * bottom
        let calculation = top / bottom
        return calculation
    }
}
