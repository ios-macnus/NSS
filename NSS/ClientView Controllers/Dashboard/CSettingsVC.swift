//
//  CSettingsVC.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit

class CSettingsVC: ParentVc {

    @IBOutlet weak var viewBack: UIView!
    var strBack = ""
    override var payLoad: [String : Any]? {
        didSet {
            if let titleB = payLoad?["selFrom"] as? String {
                self.strBack = titleB
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(strBack == "Home") {
            viewBack.isHidden = false
        } else {
            viewBack.isHidden = true
        }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnClickAction(_ sender: UIButton) {
        
        switch sender.tag {
        case 1://Profile settings
            self.goToPresent(self, storyBoard: .settings, id: .profileSettingsVC, payLoad: payLoad)
            break
        case 2://Account Settings
            self.goToPresent(self, storyBoard: .settings, id: .accountSettingsVC, payLoad: payLoad)
            break
        case 3://Job statistics
            
            break
        case 4://Payments
            
            break
        case 5://About
            
            break
        case 6://Contact us
            
            break
        case 7://Rate us
            
            break
        default:
            break
        }
    }

}
