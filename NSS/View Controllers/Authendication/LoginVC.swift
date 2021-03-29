//
//  LoginVC.swift
//  NSS
//  Created by Gowma on 24/01/21.
//

import UIKit

class LoginVC: ParentVc {
    
    @IBOutlet weak var viewTxt1Bg: UIView!
    @IBOutlet weak var viewTxt2Bg: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgEye: UIImageView!
    private var pwdShow = false
    var viewModel = loginDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = "vignesh@nss.com"
        txtPassword.text = "test123"
        viewTxt1Bg.layer.borderWidth = 1.0
        viewTxt1Bg.layer.borderColor = UIColor.black.cgColor
        viewTxt2Bg.layer.borderWidth = 1.0
        viewTxt2Bg.layer.borderColor = UIColor.black.cgColor
        txtEmail.becomeFirstResponder()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .forgotPassword, payLoad: payLoad)
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .registerMainVC, payLoad: payLoad)
    }
    
    @IBAction func btnPwdShow(_ sender: Any) {
        if pwdShow {
            imgEye.image = UIImage.init(named: "eye-off")
            txtPassword.isSecureTextEntry = true
            pwdShow = false

        } else {
            imgEye.image = UIImage.init(named: "eye")
            pwdShow = true
            txtPassword.isSecureTextEntry = false
        }
    }
    @IBAction func btnLogin(_ sender: Any) {

        if txtEmail.text == "" {
            self.view.makeToast("Enter email", duration: 3.0, position: .bottom)
        } else if !isValidEmail(txtEmail.text!){
            self.view.makeToast("Enter valid email", duration: 3.0, position: .bottom)
        } else if(txtPassword.text == ""){
            self.view.makeToast("Enter password", duration: 3.0, position: .bottom)
        } else {
            fetchLoginSubmitData()
        }

    }
    
    func fetchLoginSubmitData() {
        
        
        showOnViewTwins()
        
        viewModel.loginSubmit(loginDataRequestModel) { [weak self] (flag) in
            if flag {
                //self?.collView.reloadData()
                //print("-----")
                //print(self?.viewModel.bannerResponse?.gender ?? "")
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                  let tabbar = storyboard.instantiateViewController(withIdentifier: "DashTabVC")
                self?.tabBarController?.tabBar.tintColor = UIColor.red
                self?.tabBarController?.tabBar.unselectedItemTintColor = UIColor.green
                  let navigationController = UINavigationController(rootViewController: tabbar)
                  navigationController.modalPresentationStyle = .fullScreen
                  
                  self?.present(navigationController, animated: true, completion: nil)
                 self?.hideLoadingHub()
            } else {
                self?.hideLoadingHub()
                self?.view.makeToast("User is not registered ,Please register before login", duration: 3.0, position: .bottom)
                self?.txtEmail.text = ""
                self?.txtPassword.text = ""
                self?.txtEmail.becomeFirstResponder()
            }
        }
    }
    
    var loginDataRequestModel: [String: Any] {
        return [
            "email": txtEmail.text!,
            "password": txtPassword.text!,
            //"Email": UserDefaults().get(key: .email) as Any
        ]
    }
    
}
// MARK: UITextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
