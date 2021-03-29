//
//  RegisterMainVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class RegisterMainVC: ParentVc {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func btnFreeLauncher(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RegisterFreeLauncherVC") as! RegisterFreeLauncherVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.userType = "2"
        self.present(nextVC , animated: false, completion: nil)
        
       // self.goToPresent(self, storyBoard: .main, id: .registerFreeLauncherVC, payLoad: payLoad)
       
    }
    
    @IBAction func btnClient(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "RegisterFreeLauncherVC") as! RegisterFreeLauncherVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.userType = "3"
        self.present(nextVC , animated: false, completion: nil)
    }
    @IBAction func btnSignin(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .loginSegVC)
    }
}
