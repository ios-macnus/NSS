//
//  ViewController.swift
//  NSS
//
//  Created by Gowma on 21/01/21.
//

import UIKit
import Stripe

class ViewController: UIViewController {
    fileprivate let paymentURL: String =  "http://localhost:8888/Stripe_Test/stripe_api.php/"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//stripe intergration
/*
     {
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
     //MARK:- stripe payment
     extension HomeVC: STPAddCardViewControllerDelegate {
         func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
             dismiss(animated: true, completion: nil)
         }
         
         func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
             dismiss(animated: true, completion: nil)
             
             DispatchQueue.main.async {
                 self.createPayment(token: token.tokenId, amount: 10)
             }
         }
         
         //MARK:- Helper Methods
         fileprivate func createPayment(token: String, amount: Float) {
             AF.request(paymentURL, method: .post, parameters: ["stripeToken": token, "amount": amount * 100],encoding: JSONEncoding.default, headers: nil).responseString {
                 response in
                 print(response)
                 switch response.result {
                 case .success:
                     print("Success")
                     break
                 case .failure(let error):
                     
                     print("Failure")
                 }
             }
         }
         
         
     }
     
     let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
     let nextVC = storyBoard.instantiateViewController(withIdentifier: "cardDetails") as! CustomIntegrationViewController
     nextVC.modalPresentationStyle = .fullScreen
     nextVC.amount = Float(txtAmountPay.text!)!
     nextVC.typeB = "3"
     self.present(nextVC , animated: false, completion: nil)
     */
}

