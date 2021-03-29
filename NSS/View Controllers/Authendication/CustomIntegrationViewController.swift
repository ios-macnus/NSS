//
//  CustomIntegrationViewController.swift
//  StripeIntegrationExample
//
//  Created by Farrukh Javeid on 02/05/2019.
//  Copyright © 2019 The Right Software. All rights reserved.
//

import UIKit
import Stripe
import Alamofire

class CustomIntegrationViewController: UIViewController {
    
    //MARK:- IBOutlets
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var expiryTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var paymentbtn: UIButton!

    //MARK:- Properties
    fileprivate let paymentURL: String = "http://localhost:8888/Stripe_Test/stripe_api.php/"
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    var amount : Float = 0.0
    var typeB = "1"
    var bookedIdB = ""
    var alertMsg = ""
    var fromPage = ""

    //MARK:- UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        expiryTextField.inputView = pickerView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let doneToolbar:UIToolbar = UIToolbar()
        doneToolbar.barStyle = .blackTranslucent
        doneToolbar.tintColor = UIColor.white
        doneToolbar.items = [
            UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapToolbarNext))
        ]
        doneToolbar.sizeToFit()
        expiryTextField.inputAccessoryView = doneToolbar
        
    }
    
    @objc func didTapToolbarNext() {
        self.expiryTextField.resignFirstResponder()
        self.cvvTextField.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let _:UIEdgeInsets = UIEdgeInsets.zero
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //MARK:- GUI Events
    @IBAction func makePaymentButtonPressed(_ sender: Any) {
        
        if (self.cardNumberField.text?.isEmpty)! {
            self.view.makeToast("Please enter the card number", duration: 1.0, position: .bottom)
        }else if (self.cardNumberField.text?.count)! < 16 {
            self.view.makeToast("Please enter the valid card number", duration: 1.0, position: .bottom)
        }else if (self.expiryTextField.text?.isEmpty)! {
            self.view.makeToast("Please enter the card expiry month and year", duration: 1.0, position: .bottom)
        }else if (self.cvvTextField.text?.isEmpty)! {
            self.view.makeToast("Please enter the cvv number", duration: 1.0, position: .bottom)
        }else if (self.cvvTextField.text?.count)! < 3 {
            self.view.makeToast("Please enter the valid cvv number", duration: 1.0, position: .bottom)
        }else {
            self.paymentbtn.isUserInteractionEnabled = false

            //card parameters
            let stripeCardParams = STPCardParams()
            stripeCardParams.number = cardNumberField.text
            let expiryParameters = expiryTextField.text?.components(separatedBy: "/")
            stripeCardParams.expMonth = UInt(expiryParameters?.first ?? "0") ?? 0
            stripeCardParams.expYear = UInt(expiryParameters?.last ?? "0") ?? 0
            stripeCardParams.cvc = cvvTextField.text
            
            //converting into token
            let config = STPPaymentConfiguration.shared()
            let stpApiClient = STPAPIClient.init(configuration: config)
            stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
                
                if error == nil {
                    print("tototototot : \(token!.tokenId)")
                    //Success
                    DispatchQueue.main.async { [self] in
                        self.createPayment(token: token!.tokenId,amount: Float(self.amount))
                    }
                } else {
                    self.view.makeToast("Incorrect Card Details", duration: 1.0, position: .bottom)
                    //failed
                    print("Failed")
                    self.paymentbtn.isUserInteractionEnabled = true

                }
            }
        }
        
    }
    
    @IBAction func tapGestureInvoked(_ sender: Any) {
        view.endEditing(true)
    }
    
    //MARK:- Helper Methods
    fileprivate func createPayment(token: String, amount: Float) {
        
        let accessTokenT = UserDefaults.standard.string(forKey: "access_token")
        let headers: HTTPHeaders = ["Authorization" : accessTokenT!,
                                    "Content-Type": "application/json"]
        var params = [:] as! Dictionary<String,AnyObject>
        let userIdT = UserDefaults.standard.string(forKey: "user_id")
        if  typeB == "3" {
            params = ["token": token as AnyObject, "amount": amount as AnyObject,"currency_code": "sgd" as AnyObject, "user_id": userIdT as AnyObject, "type" : typeB as AnyObject, "type_id" : userIdT! as AnyObject ]
        } else {
            params = ["token": token as AnyObject, "amount": amount as AnyObject,"currency_code": "sgd" as AnyObject, "user_id": userIdT as AnyObject, "type" : typeB as AnyObject, "type_id" : self.bookedIdB as AnyObject ]
            
        }
        AF.request("\(delegate.apiURL)/api/v1/auto_insure/stripe_integration", method: .post, parameters: params,encoding: JSONEncoding.default, headers: headers).responseString {
            response in
            print(response)
            
            switch response.result {
            case .success:
                print("Success")
                self.paymentbtn.isUserInteractionEnabled = true

                if(self.bookedIdB == "") {
                    UserDefaults.standard.set("TopUpMade", forKey: "topUp")
                    self.dismiss(animated: false, completion: nil)
                }else {
                    if self.fromPage == "Invoice" {
                        self.view.makeToast("Payment Success", duration: 3.0, position: .bottom)

                        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.runTimedCode1), userInfo: nil, repeats: false)

                    } else {
                    self.afterPaymentNav()
                    }
                }
                
                break
            case .failure(let error):
                
                print("Failure")
                self.paymentbtn.isUserInteractionEnabled = true

                self.view.makeToast("\(error)", duration: 1.0, position: .bottom)
            }
        }
    }
    @objc func runTimedCode1() {
        self.dismiss(animated: false, completion: nil)

    }
    func afterPaymentNav() {
        
        let alertController = UIAlertController(
            title: self.alertMsg,
            message: "\nDo you want to book another service",
            preferredStyle: .alert)
        //In order to be notified about adorable kittens near you, please open
        let cancelAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            
            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainTabViewVC")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            if let tabBarController = initialViewController as? UITabBarController {
                tabBarController.selectedIndex = 2
            }
        }
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "No", style: .default) { (action) in
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "MyBookingVC") as! MyBookingVC
            nextVC.fromPage = "location"
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC , animated: false, completion: nil)
            
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CustomIntegrationViewController: UITextFieldDelegate { // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        switch textField {
        case cardNumberField :
            self.cardNumberField.resignFirstResponder()
            self.expiryTextField.becomeFirstResponder()
            break
        case expiryTextField :
            self.expiryTextField.resignFirstResponder()
            self.cvvTextField.becomeFirstResponder()
            break
        case cvvTextField :
            self.cvvTextField.resignFirstResponder()
            self.dismissKeyboard()
            break
        default  :
            self.dismissKeyboard()
            print("Empty")
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        switch textField {
        case cardNumberField :
            let maxLength = 16
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            if string != filtered {
                return false
            }
            return newString.length <= maxLength
        case expiryTextField :
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            if string != filtered {
                return false
            }
            
            if (isBackSpace == -92) {
                self.expiryTextField.text = ""
                return true
            } else {
                let maxLength = 5
                let currentString: NSString = textField.text! as NSString
                let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
                return newString.length <= maxLength
            }
        case cvvTextField :
            let maxLength = 3
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            
            if string != filtered {
                return false
            }
            
            return newString.length <= maxLength
        default  :
            return false
        }}
    
    // dismiss the keyboard presence
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
}

extension CustomIntegrationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    enum ExpDate: Int, CaseIterable {
        case month
        case year
        var data: [String] {
            switch self {
            case .month:
                return (1...12).map({ String(format: "%02d", arguments: [$0]) })
            case .year:
                let year = Calendar.current.component(.year, from: Date())
                return (year...year + 20).map(String.init)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ExpDate.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ExpDate(rawValue: component)?.data.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ExpDate(rawValue: component)?.data[row] ?? ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = ExpDate.month.data[pickerView.selectedRow(inComponent: ExpDate.month.rawValue)]
        let year = ExpDate.year.data[pickerView.selectedRow(inComponent: ExpDate.year.rawValue)]
        self.expiryTextField.text = "\(month)/\(year)"
    }
}
