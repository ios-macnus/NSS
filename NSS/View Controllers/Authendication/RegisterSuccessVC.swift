//
//  RegisterSuccessVC.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class RegisterSuccessVC: ParentVc {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnHome(_ sender: Any) {
        self.goToPresent(self, storyBoard: .main, id: .loginSegVC)
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
