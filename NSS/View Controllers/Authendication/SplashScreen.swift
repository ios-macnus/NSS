//
//  SplashScreen.swift
//  NSS
//
//  Created by Gowma on 24/01/21.
//

import UIKit

class SplashScreen: ParentVc {

    var timer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: false)
    }
    
    @objc func runTimedCode() {
        
        let userIdT = UserDefaults.standard.string(forKey: "freelancer_user_id")
        let clientIdT = UserDefaults.standard.string(forKey: "client_user_id")
        if(userIdT == "" && clientIdT == "") {
            self.goToPresent(self, storyBoard: .main, id: .tutorialVC)
        } else if(userIdT != "") {
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
              let tabbar = storyboard.instantiateViewController(withIdentifier: "DashTabVC")
            self.tabBarController?.tabBar.tintColor = UIColor.red
            self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.green
              let navigationController = UINavigationController(rootViewController: tabbar)
              navigationController.modalPresentationStyle = .fullScreen
              
              self.present(navigationController, animated: true, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "ClientDashboard", bundle: nil)
            let tabbar = storyboard.instantiateViewController(withIdentifier: "ClientDashTabVC")
            self.tabBarController?.tabBar.tintColor = UIColor.red
            self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.green
            let navigationController = UINavigationController(rootViewController: tabbar)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationBar.isHidden = true
            
            self.present(navigationController, animated: true, completion: nil)
        }

        if timer != nil {
                  timer!.invalidate()
                  timer = nil
              }
        
    }

}
