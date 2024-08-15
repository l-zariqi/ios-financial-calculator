//
//  LoansViewController.swift
//  CW1
//
//  Created by Lind Zariqi on 23/03/2022.
//

import UIKit

class LoansViewController: UIViewController, UITextFieldDelegate {
    
    // Enumeration cases to define which TF will be calculated
    // Source: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    enum LoansFinding {
        case Empty
        case PrincipleAmount
        case MonthlyPayment
        case NumberOfMonths
    }
    
    @IBOutlet weak var principleAmountTF: UITextField!
    @IBOutlet weak var monthlyPaymentTF: UITextField!
    @IBOutlet weak var interestRateTF: UITextField!
    @IBOutlet weak var numberOfMonthsTF: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var finding = LoansFinding.Empty
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let backgrounded = #selector(appMovedToBackground)
        NotificationCenter.default.addObserver(self, selector: backgrounded, name: UIApplication.willResignActiveNotification, object: nil)
        
        readTextField()
        
        // Hides the keyboard when the user touches outside of a text field:
        // Source: https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tapGesture)

    }
    
    // Saves the current state of the app for when it is backgrounded or closed
    @objc func appMovedToBackground() {
        print("App Backgrounded or Closed")

        defaults.set(principleAmountTF.text, forKey: "loansPrincipleAmount")
        defaults.set(monthlyPaymentTF.text, forKey: "loansMonthlyPayment")
        defaults.set(interestRateTF.text, forKey: "loansInterestRate")
        defaults.set(numberOfMonthsTF.text, forKey: "loansNumberOfMonths")
    }
    
    func readTextField() {
        principleAmountTF.text = defaults.string(forKey: "loansPrincipleAmount")
        monthlyPaymentTF.text = defaults.string(forKey: "loansMonthlyPayment")
        interestRateTF.text = defaults.string(forKey: "loansInterestRate")
        numberOfMonthsTF.text = defaults.string(forKey: "loansNumberOfMonths")
        
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        // Dismisses the keyboard when "Calculate" button is pressed
        // Source: https://stackoverflow.com/questions/31952064/dismissing-the-keyboard-when-a-button-is-pressed-programmatically-with-swift
        self.view.endEditing(true)
        
        let principleAmount = principleAmountTF.validateDouble
        let monthlyPayment = monthlyPaymentTF.validateDouble
        let interestRate = interestRateTF.validateDouble
        let numberOfMonths = numberOfMonthsTF.validateDouble
        
        let validationError = validateInput(principleAmount: principleAmount, monthlyPayment: monthlyPayment, interestRate: interestRate, numberOfPayments: numberOfMonths)
        
        switch finding {
        case .PrincipleAmount:
            let result = Mortgage.initialValue(monthlyPayment: monthlyPayment!, interestRate: interestRate!, numberOfPayments: numberOfMonths! / 12)
            principleAmountTF.text = "£" + String(format: "%.2f", result)
        case .NumberOfMonths:
            let result = Mortgage.numberOfPayments(principleAmount: principleAmount!, interestRate: interestRate!, monthlyPayment: monthlyPayment!)
            numberOfMonthsTF.text = String(format: "%.2f", result * 12)
        case .MonthlyPayment:
            let result = Mortgage.monthlyPayment(principleAmount: principleAmount!, interestRate: interestRate!, numberOfPayments: numberOfMonths! / 12)
            monthlyPaymentTF.text = "£" + String(format: "%.2f", result)
        default:
            return
        }
    }
    
    // Action for clearing all text fields when "Clear All" button is pressed
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        self.principleAmountTF.text = ""
        self.monthlyPaymentTF.text = ""
        self.interestRateTF.text = ""
        self.numberOfMonthsTF.text = ""
    }
    
    @IBAction func textFieldEdited(_ sender: UITextField) {
        if sender.filteredText == "" {
            sender.text = sender.filteredText
            return
        }
        switch sender.tag {
        case 1:
            sender.text = "£ " + sender.filteredText
        case 2:
            sender.text = sender.filteredText + " %"
        default:
            break
        }
    }
    
    // Validating input for the TF
    func validateInput(principleAmount: Double!, monthlyPayment: Double!, interestRate: Double!, numberOfPayments: Double!) -> String! {
        var counter = 0
        
        if (principleAmount == nil) {
            counter += 1
            finding = .PrincipleAmount
        }
        
        if (monthlyPayment == nil) {
            counter += 1
            finding = .MonthlyPayment
        }
        
        if (numberOfPayments == nil) {
            counter += 1
            finding = .NumberOfMonths
        }
        
        if counter > 1 {
            finding = .Empty
        }
        
        if interestRate == nil {
        }
        
        if counter == 0 && finding == .Empty {
            finding = .Empty
        }
        
        if monthlyPayment != nil && principleAmount != nil {
            if monthlyPayment > principleAmount {
                finding = .Empty
            }
        }
        
        if principleAmount != nil && principleAmount == 0 {
            finding = .Empty
        }
        
        if monthlyPayment != nil && monthlyPayment == 0 {
            finding = .Empty
        }
        
        if numberOfPayments != nil && numberOfPayments == 0 {
            finding = .Empty
        }
        
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
