//
//  CPostJobViewAfterVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit

class CPostJobViewAfterVC: ParentVc {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOwnerName: UILabel!
    @IBOutlet weak var lblInfo1: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblInfo2: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblJobOverview: UILabel!
    @IBOutlet weak var lblJobRequirements: UILabel!
    @IBOutlet weak var lblJobQualification: UILabel!
    
    
    var arrSecDashForB = [[String:AnyObject]]()
    var jobTitleB = ""
    var jobLocation = ""
    var jobCost = ""
    var jobOverview = ""
    var jobRequirements = ""
    var jobQualificationsB = ""
    var JobExpiryDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblTitle.text = jobTitleB
        lblOwnerName.text = ""
        lblInfo1.text = jobLocation
        lblDate.text = ""
        lblInfo2.text = ""
        lblExpiryDate.text = "Post Expiry Date " + JobExpiryDate
        lblPrice.text = " Price $ " + jobCost
        lblJobOverview.text = jobOverview
        lblJobRequirements.text = jobRequirements
        lblJobQualification.text = jobQualificationsB
    }
    
    @IBAction func btnBack(_ sender: Any) {
        goBack()
    }
    
    @IBAction func btnViewApplications(_ sender: Any) {
        goBack()
    }
   
    func goBack() {
        let storyboard = UIStoryboard(name: "ClientDashboard", bundle: nil)
        let tabbar = storyboard.instantiateViewController(withIdentifier: "ClientDashTabVC")
        self.tabBarController?.tabBar.tintColor = UIColor.red
        self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.green
        let navigationController = UINavigationController(rootViewController: tabbar)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.isHidden = true
        
        self.present(navigationController, animated: true, completion: nil)
    }

}
