//
//  ResetPasswordVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class ResetPasswordVC: ParentVc {

    @IBOutlet weak var viewTxt1Bg: UIView!
    @IBOutlet weak var viewTxt2Bg: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTxt1Bg.layer.borderWidth = 1.0
        viewTxt1Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt2Bg.layer.borderWidth = 1.0
        viewTxt2Bg.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
 
    @IBAction func btnCreate(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .passwordSuccessVC)
    }
    
}
// MARK: UITextFieldDelegate
extension ResetPasswordVC: UITextFieldDelegate {
    
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
