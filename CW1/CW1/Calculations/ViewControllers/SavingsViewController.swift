//
//  SavingsViewController.swift
//  CW1
//
//  Created by Lind Zariqi on 23/03/2022.
//

import UIKit

class SavingsViewController: UIViewController, UITextFieldDelegate {
    
    // Enumeration cases to define which TF will be calculated
    // Source: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    enum SavingsFinding {
        case Empty
        case FutureAmount
        case MonthlyPayment
        case NumberOfPayments
    }

    @IBOutlet weak var principleAmountTF: UITextField!
    @IBOutlet weak var futureAmountTF: UITextField!
    @IBOutlet weak var monthlyPaymentTF: UITextField!
    @IBOutlet weak var interestRateTF: UITextField!
    @IBOutlet weak var numberOfPaymentsTF: UITextField!
    @IBOutlet weak var paymentPeriodSwitch: UISwitch!
    @IBOutlet weak var paymentPeriodLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var finding = SavingsFinding.Empty
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

        defaults.set(principleAmountTF.text, forKey: "savingsPrincipleAmount")
        defaults.set(futureAmountTF.text, forKey: "savingsFutureAmount")
        defaults.set(monthlyPaymentTF.text, forKey: "savingsMonthlyPayment")
        defaults.set(interestRateTF.text, forKey: "savingsInterestRate")
        defaults.set(numberOfPaymentsTF.text, forKey: "savingsNumberOfPayments")
    }
    
    func readTextField() {
        principleAmountTF.text = defaults.string(forKey: "savingsPrincipleAmount")
        futureAmountTF.text = defaults.string(forKey: "savingsFutureAmount")
        monthlyPaymentTF.text = defaults.string(forKey: "savingsMonthlyPayment")
        interestRateTF.text = defaults.string(forKey: "savingsInterestRate")
        numberOfPaymentsTF.text = defaults.string(forKey: "savingsNumberOfPayments")
        
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        // Dismisses the keyboard when "Calculate" button is pressed
        // Source: https://stackoverflow.com/questions/31952064/dismissing-the-keyboard-when-a-button-is-pressed-programmatically-with-swift
        self.view.endEditing(true)
        
        let principleAmount = principleAmountTF.validateDouble
        let futureAmount = futureAmountTF.validateDouble
        let monthlyPayment = monthlyPaymentTF.validateDouble
        let interestRate = interestRateTF.validateDouble
        let numberOfPayments = numberOfPaymentsTF.validateDouble
        
        let validationError = validateInput(interestRate: interestRate, futureAmount: futureAmount, principleAmount: principleAmount, numberOfPayments: numberOfPayments, monthlyPayment: monthlyPayment)
        
        switch finding {
        case .FutureAmount:
            let result: Double
            if (!paymentPeriodSwitch.isOn) {
                result = Savings.futureValueEnd(principleAmount: principleAmount!, monthlyPayment: monthlyPayment!, interestRate: interestRate!, numberOfPayments: numberOfPayments!)
            } else {
                result = Savings.futureValueBegin(principleAmount: principleAmount!, monthlyPayment: monthlyPayment!, interestRate: interestRate!, numberOfPayments: numberOfPayments!)
            }
            futureAmountTF.text = "£" + String(format: "%.2f", result)
        case .NumberOfPayments:
            let result: Double
            if (!paymentPeriodSwitch.isOn) {
                result = Savings.numberOfPaymentsEnd(principleAmount: principleAmount!, futureAmount: futureAmount!, interestRate: interestRate!, monthlyPayment: monthlyPayment!)
            } else {
                result = Savings.numberOfPaymentsBegin(principleAmount: principleAmount!, futureAmount: futureAmount!, interestRate: interestRate!, monthlyPayment: monthlyPayment!)
            }
            numberOfPaymentsTF.text = String(format: "%.2f", result)
        case .MonthlyPayment:
            let result: Double
            if (!paymentPeriodSwitch.isOn) {
                result = Savings.monthlyPaymentEnd(principleAmount: principleAmount!, futureAmount: futureAmount!, interestRate: interestRate!, numberOfPayments: numberOfPayments!)
            } else {
                result = Savings.monthlyPaymentBegin(principleAmount: principleAmount!, futureAmount: futureAmount!, interestRate: interestRate!, numberOfPayments: numberOfPayments!)
            }
            monthlyPaymentTF.text = "£" + String(format: "%.2f", result)
        default:
            return
        }
    }
    
    // Validating input for the TF
    func validateInput(interestRate: Double!, futureAmount: Double!, principleAmount: Double!, numberOfPayments: Double!, monthlyPayment: Double!) -> String! {
        var counter = 0
        
        if (futureAmount == nil) {
            counter += 1
            finding = .FutureAmount
        }
        
        if (monthlyPayment == nil) {
            counter += 1
            finding = .MonthlyPayment
        }
        
        if (numberOfPayments == nil) {
            counter += 1
            finding = .NumberOfPayments
        }
        
        if counter > 1 {
            finding = .Empty
        }
        
        if interestRate == nil {
        }
        
        if principleAmount == nil {
        }
        
        if counter == 0 && finding == .Empty {
            finding = .Empty
        }
        
        if principleAmount != nil && futureAmount != nil {
            if principleAmount > futureAmount {
            }
        }
        
        if monthlyPayment != nil && futureAmount != nil {
            if monthlyPayment > futureAmount {
            }
        }
        
        if numberOfPayments != nil && numberOfPayments == 0 {
        }
        
        if futureAmount != nil && futureAmount == 0 {
        }
        
        if monthlyPayment != nil && monthlyPayment == 0 {
        }
        
        return nil
    }
    
    // Action for clearing all text fields when "Clear All" button is pressed
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        self.principleAmountTF.text = ""
        self.futureAmountTF.text = ""
        self.monthlyPaymentTF.text = ""
        self.interestRateTF.text = ""
        self.numberOfPaymentsTF.text = ""
    }
    
    @objc func switchLabelTapped(sender:UITapGestureRecognizer) {
        paymentPeriodSwitch.setOn(!paymentPeriodSwitch.isOn, animated: true)
        changeSwitchLabel()
    }
    
    // Pressing the switch will change the payment period
    func changeSwitchLabel() {
        if paymentPeriodSwitch.isOn {
            paymentPeriodLabel.text = "Beginning of the Month"
        } else {
            paymentPeriodLabel.text = "End of the Month"
        }
    }
    
    
    @IBAction func paymentPeriodSwitchChanged(_ sender: UISwitch) {
        changeSwitchLabel()
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
