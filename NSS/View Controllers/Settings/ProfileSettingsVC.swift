//
//  ProfileSettingsVC.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit

class ProfileSettingsVC: ParentVc {

    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtGmail: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnSave(_ sender: Any) {
    }
    

}
// MARK: UITextFieldDelegate
extension ProfileSettingsVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
