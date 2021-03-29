//
//  ForgotPasswordVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class ForgotPasswordVC: ParentVc {
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var viewTxt1Bg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTxt1Bg.layer.borderWidth = 1.0
        viewTxt1Bg.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSend(_ sender: Any) {
        viewPopup.isHidden = false
    }
    @IBAction func btnOkGotit(_ sender: Any) {
        viewPopup.isHidden = true
        self.goToPresent(self, storyBoard: .main, id: .resetPasswordVC)
    }
    
}
// MARK: UITextFieldDelegate
extension ForgotPasswordVC: UITextFieldDelegate {
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        if let txt = textField.text, let newRange = txt.range(from: range) {
    //
    //            let finalString = txt.replacingCharacters(in: newRange, with: string)
    //
    //            if finalString.count > 0 {
    //                viewModel.email = finalString
    //            }else {
    //                btnSubmit.isEnabled = false
    //                btnSubmit.setBackgroundImage(UIImage(named : "buttonBgGray"), for: .normal)
    //            }
    //        }
    //
    //        return true
    //    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
    }
}
