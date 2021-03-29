//
//  PasswordSuccessVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class PasswordSuccessVC: ParentVc {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLogin(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .loginVC)
    }

}
