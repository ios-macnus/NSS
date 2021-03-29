//
//  AccountSettingsVC.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit

class AccountSettingsVC: ParentVc {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnClickAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 1://Notification settings
            
            break
        case 2://Dark Mode
            
            break
        case 3://Delete Account
            
            break
        case 4://Terms & Conditions
            
            break
        case 5://Logout
            UserDefaults.standard.set("", forKey: "freelancer_user_id")
            UserDefaults.standard.set("", forKey: "client_user_id")
            self.goToPresent(self, storyBoard: .main, id: .registerMainVC)
            
            break
        default:
            break
        }
    }
}
