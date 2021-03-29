//
//  CPostJobReviewVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CPostJobReviewVC: ParentVc {

    @IBOutlet weak var roundedView1: UIView!
    @IBOutlet weak var roundedView2: UIView!
    @IBOutlet weak var roundedView3: UIView!
    @IBOutlet weak var roundedView4: UIView!
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
    @IBOutlet weak var viewSuccessPopup: UIView!
    
    
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
        
        roundedView1.makeCircular()
        roundedView2.makeCircular()
        roundedView3.makeCircular()
        roundedView4.makeCircular()
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
    
    @IBAction func btnHome(_ sender: Any) {
        goBack()
    }
    @IBAction func btnViewPost(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ClientPostJob", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CPostJobViewAfterVC") as! CPostJobViewAfterVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.arrSecDashForB = arrSecDashForB
        nextVC.jobTitleB = jobTitleB
        nextVC.jobLocation = jobLocation
        nextVC.jobCost = jobCost
        nextVC.jobOverview = jobOverview
        nextVC.jobRequirements = jobRequirements
        nextVC.jobQualificationsB = jobQualificationsB
        nextVC.JobExpiryDate = JobExpiryDate
        self.present(nextVC , animated: false, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    @IBAction func btnNext(_ sender: Any) {

        SubmitPost()
        
    }

    func SubmitPost() {
         
         //ANLoader.showLoading("Loading", disableUI: false)
         //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
        /*
         {
             "job_title":"Truck Unloading",
             "job_city_id":1,
             "job_starts_from":"2020-12-01 10:12",
             "job_ends_on":"2020-12-12 10:15",
             "job_highlights":"SPOT PAYMENT",
             "job_overview":"Job Overview Provide a brief, 4-sentence description of the role, what success in the position looks like, and how it fits into the company or organization overall. Requirement List the essential duties required to carry out this job. List them in order of importance. Use complete sentences. Start sentences with verbs. Use the present tense. Use gender-neutral language. Qualifications Education level. Experience. Specific skills. Personal characteristics. Certifications. Licenses. Physical abilities",
             "job_requirement":"Mechanic",
             "job_qualification":"Mechanic",
             "job_type_id":12,
             "job_price":1200,
             "client_user_id":3,
             "skills":[4,1]
         }
         */
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let calendar =  Calendar(identifier: .gregorian) //Calendar.current
        let currentDate = Date()
         
        let userIdT = UserDefaults.standard.string(forKey: "client_user_id")
        let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
        
       let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
        "Content-Type": "application/json"]
        
        let param: [String: Any] = ["job_title" : jobTitleB ,"job_city_id" : 1 ,"job_starts_from" : formatter.string(from:currentDate ) , "job_ends_on" : JobExpiryDate, "job_highlights" : jobOverview, "job_overview" : jobOverview, "job_requirement" : jobRequirements, "job_qualification" : jobQualificationsB, "job_type_id" : "13","job_price":jobCost , "client_user_id":"\(userIdT!)", "skills": [1,4] as NSArray]
         
         //"\(demourl)dashboard.php"
         AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/create_jobPost",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
             
             switch responseData.result {
             case .success(let value):
                 let swiftyJsonVar = JSON(value)
                 print(swiftyJsonVar)
                 if let resData = swiftyJsonVar[].dictionaryObject {
                     let status = (resData)["status"] as! Bool
                     let message = (resData)["message"] as! String
                     if status {
                        
                        self.view.makeToast("\(message)", duration: 1.0, position: .bottom)
                         Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runTimedCode1), userInfo: nil, repeats: false)
                         
                     }else{
                         self.view.makeToast("\(message)", duration: 3.0, position: .bottom)
                     }
                     

                     //ANLoader.hide()
                 }
             case .failure(let error):
                 print(error)
                 //ANLoader.hide()
             }
             
           
         }
     }
     
      @objc func runTimedCode1() {

        self.viewSuccessPopup.isHidden = false
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
