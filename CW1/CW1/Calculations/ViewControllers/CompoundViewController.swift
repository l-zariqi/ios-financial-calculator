//
//  CompoundViewController.swift
//  CW1
//
//  Created by Lind Zariqi on 23/03/2022.
//

import UIKit

class CompoundViewController: UIViewController, UITextFieldDelegate {
    
    // Enumeration cases to define which TF will be calculated
    // Source: https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
    enum CompoundFinding {
        case Empty
        case PrincipleAmount
        case FutureValue
        case InterestRate
        case NumberOfPayments
    }
    
    @IBOutlet weak var principleAmountTF: UITextField!
    @IBOutlet weak var futureAmountTF: UITextField!
    @IBOutlet weak var interestRateTF: UITextField!
    @IBOutlet weak var numberOfPaymentsTF: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var finding = CompoundFinding.Empty
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

        defaults.set(principleAmountTF.text, forKey: "compoundPrincipleAmount")
        defaults.set(futureAmountTF.text, forKey: "compoundFutureAmount")
        defaults.set(interestRateTF.text, forKey: "compoundInterestRate")
        defaults.set(numberOfPaymentsTF.text, forKey: "compoundNumberOfPayments")
    }
    
    func readTextField() {
        principleAmountTF.text = defaults.string(forKey: "compoundPrincipleAmount")
        futureAmountTF.text = defaults.string(forKey: "compoundFutureAmount")
        interestRateTF.text = defaults.string(forKey: "compoundInterestRate")
        numberOfPaymentsTF.text = defaults.string(forKey: "compoundNumberOfPayments")
        
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
        // Dismisses the keyboard when "Calculate" button is pressed
        // Source: https://stackoverflow.com/questions/31952064/dismissing-the-keyboard-when-a-button-is-pressed-programmatically-with-swift
        self.view.endEditing(true)
        
        let principleAmount = principleAmountTF.validateDouble
        let futureAmount = futureAmountTF.validateDouble
        let interestRate = interestRateTF.validateDouble
        let numberOfPayments = numberOfPaymentsTF.validateDouble
        
        let validationError = validateInput(interestRate: interestRate, futureAmount: futureAmount, principleAmount: principleAmount, numberOfPayments: numberOfPayments)
        
        switch finding {
        case .PrincipleAmount:
            let result = Compound.CalculatePrincipleAmount(interestRate: interestRate!, futureValue: futureAmount!, numberOfPayments: numberOfPayments!)
            principleAmountTF.text = "£" + String(format: "%.2f", result)
        case .NumberOfPayments:
            let result = Compound.CalculateNumberOfPayments(interestRate: interestRate!, futureValue: futureAmount!, principleAmount: principleAmount!)
            numberOfPaymentsTF.text = String(format: "%.2f", result)
        case .FutureValue:
            let result = Compound.CalculateFutureValue(interestRate: interestRate!, principleAmount: principleAmount!, numberOfPayments: numberOfPayments!)
            futureAmountTF.text = "£" + String(format: "%.2f", result)
        case .InterestRate:
            let result = Compound.CalculateInterestRate(futureValue: futureAmount!, principleAmount: principleAmount!, numberOfPayments: numberOfPayments!)
            interestRateTF.text = String(format: "%.2f", result) + "%"
        default:
            return
            
        }
        
    }
        
    // Action for clearing all text fields when "Clear All" button is pressed
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        self.principleAmountTF.text = ""
        self.futureAmountTF.text = ""
        self.interestRateTF.text = ""
        self.numberOfPaymentsTF.text = ""
    }
    
    
    // Validating input for the TF
    func validateInput(interestRate: Double!, futureAmount: Double!, principleAmount: Double!, numberOfPayments: Double!) -> String! {
        var counter = 0
        
        if (futureAmount == nil) {
            counter += 1
            finding = .FutureValue
        }
        
        if (principleAmount == nil) {
            counter += 1
            finding = .PrincipleAmount
        }
        
        if (numberOfPayments == nil) {
            counter += 1
            finding = .NumberOfPayments
        }
        
        if (interestRate == nil) {
            counter += 1
            finding = .InterestRate
        }
        
        if counter > 1 {
            finding = .Empty
        }
        
        if interestRate == 0 {
        }
        
        if counter == 0 && finding == .Empty {
            finding = .Empty
        }
        
        if futureAmount != nil && principleAmount != nil {
            if principleAmount > futureAmount && finding != .PrincipleAmount {
                finding = .Empty
            }
        }
        
        if principleAmount != nil && principleAmount == 0 {
        }
        
        if futureAmount != nil && futureAmount == 0 {
        }
        
        if numberOfPayments != nil && numberOfPayments == 0 {
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
