//
//  JobDetailsVC.swift
//  NSS
//
//  Created by Gowma on 18/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class JobDetailsVC: ParentVc {
    
    @IBOutlet weak var viewDateBg: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblInfo1: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPostedDate: UILabel!
    @IBOutlet weak var lblJobDate: UILabel!
    @IBOutlet weak var lblExpiryDate: UILabel!
    @IBOutlet weak var lblJobOverview: UILabel!
    @IBOutlet weak var lblJobRequirement: UILabel!
    @IBOutlet weak var lblJobQualification: UILabel!
    var arrSecDashFor = [[String:AnyObject]]()
    
    var request_progress_id = ""
    var client_job_post_id = ""
    var freelancer_user_id = ""
    var client_user_id = ""
    var isFav = false
    var isApplied = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDateBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        viewDateBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        viewDateBg.layer.shadowOpacity = 0.5
        viewDateBg.layer.shadowRadius = 3.0
        viewDateBg.layer.masksToBounds = false
        viewDateBg.layer.cornerRadius = 0.0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getPostedJobDetails()
    }
    
    func getPostedJobDetails() {
        //ANLoader.showLoading("Loading", disableUI: false)
        //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
        
        let userIdT = UserDefaults.standard.string(forKey: "freelancer_user_id")
        let accessTokenT = UserDefaults.standard.string(forKey: "freelancer_AccessToken")
        let jobId = UserDefaults.standard.string(forKey: "Job_Id_Pass")!
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
                                    "Content-Type": "application/json"]
        
        
        let param: [String: Any] = ["job_id" : Int(jobId)!]
        print(param)
        print("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/freelancer/job_details/\(Int(jobId)!)")
        //"\(demourl)dashboard.php"
        AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/freelancer/job_details/\(Int(jobId)!)",method:.post, parameters: nil , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
            
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar[].dictionaryObject {
                    let status = (resData)["status"] as! Bool
                    //let message = (resData)["message"] as! String
                    if status {
                        //self.arrSecDashFor = ((resData)["data"] as! [[String:AnyObject]])
                        let dictMainT = resData["data"] as! NSDictionary
                        let dictT = dictMainT["job_details"] as! NSDictionary
                        self.lblTitle.text = "\(dictT["job_title"]!)"
                        //self.lblClientName.text = "\(dictT["job_title"]!)"
                        self.lblInfo1.text = "\(dictT["city_name"]!)"
                        self.lblPrice.text = "$ \(dictT["job_price"]!)"
                        
                        self.lblJobOverview.text = "\(dictT["job_overview"]!)"
                        self.lblJobRequirement.text = "\(dictT["job_requirement"]!)"
                        self.lblJobQualification.text = "\(dictT["job_highlights"]!)"
                        
                        self.request_progress_id = "\(dictT["request_progress_id"]!)"
                        self.client_job_post_id = "\(dictT["client_job_post_id"]!)"
                        self.client_user_id = "\(dictT["client_user_id"]!)"
                        self.isFav = dictT["is_favourite"] as! Bool
                        self.isApplied = dictT["is_applied"] as! Bool
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        let date = dateFormatter.date(from: "\(dictT["job_post_created_on"]!)")
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        self.lblJobOverview.text = "\(dateFormatter.string(from: date!))"
                        
                        let dateFormatter2 = DateFormatter()
                        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        let date2 = dateFormatter2.date(from: "\(dictT["job_starts_from"]!)")
                        dateFormatter2.dateFormat = "dd MMM yyyy"
                        self.lblJobDate.text = "\(dateFormatter2.string(from: date2!))"
                        
                        let dateFormatter3 = DateFormatter()
                        dateFormatter3.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        let date3 = dateFormatter3.date(from: "\(dictT["job_ends_on"]!)")
                        dateFormatter3.dateFormat = "dd MMM yyyy"
                        self.lblExpiryDate.text = "\(dateFormatter3.string(from: date3!))"
                        
                    }
                    
                    //ANLoader.hide()
                }
            case .failure(let error):
                print(error)
            //ANLoader.hide()
            }
            
        }
        
    }
    
    func applyJob() {
        //ANLoader.showLoading("Loading", disableUI: false)
        //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
        
        let userIdT = UserDefaults.standard.string(forKey: "freelancer_user_id")!
        let accessTokenT = UserDefaults.standard.string(forKey: "freelancer_AccessToken")
        let jobId = UserDefaults.standard.string(forKey: "Job_Id_Pass")!
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
                                    "Content-Type": "application/json"]
        
        let param: [String: Any] = ["job_id" : Int(jobId)!,"request_progress_id": self.request_progress_id,
                                    "client_job_post_id": self.client_job_post_id,
                                    "freelancer_user_id": "\(userIdT)",
                                    "is_applied": self.isApplied == true ? "0":"1",
                                    "is_favourite": self.isFav == true ? "1":"0",
                                    "client_user_id": self.client_user_id]
        print(param)
        //"\(demourl)dashboard.php"
        AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/freelancer/favourite_or_apply_job",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
            
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar[].dictionaryObject {
                    let status = (resData)["status"] as! Bool
                    self.getPostedJobDetails()
                    let message = (resData)["message"] as! String
                    self.view.makeToast("\(message)", duration: 2.0, position: .bottom)
                    //ANLoader.hide()
                }
            case .failure(let error):
                print(error)
            //ANLoader.hide()
            }
            
        }
        
    }
    
    
    func JobShortlist() {
        //ANLoader.showLoading("Loading", disableUI: false)
        //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
        
        let userIdT = UserDefaults.standard.string(forKey: "freelancer_user_id")
        let accessTokenT = UserDefaults.standard.string(forKey: "freelancer_AccessToken")
        let jobId = UserDefaults.standard.string(forKey: "Job_Id_Pass")!
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
                                    "Content-Type": "application/json"]
        
        let param: [String: Any] = ["job_id" : Int(jobId)!,"request_progress_id": self.request_progress_id,
                                    "client_job_post_id": self.client_job_post_id,
                                    "freelancer_user_id": "\(userIdT ?? "")",
                                    "is_applied": self.isApplied == true ? "1":"0",
                                    "is_favourite": self.isFav == true ? "0":"1",
                                    "client_user_id": self.client_user_id]
        
        print(param)
        //"\(demourl)dashboard.php"
        AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/freelancer/favourite_or_apply_job",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
            
            switch responseData.result {
            case .success(let value):
                let swiftyJsonVar = JSON(value)
                print(swiftyJsonVar)
                if let resData = swiftyJsonVar[].dictionaryObject {
                    let status = (resData)["status"] as! Bool
                    self.getPostedJobDetails()
                    let message = (resData)["message"] as! String
                    //ANLoader.hide()
                    self.view.makeToast("\(message)", duration: 2.0, position: .bottom)
                }
            case .failure(let error):
                print(error)
            //ANLoader.hide()
            }
            
        }
        
    }
    
    
    @IBAction func btnFavourite(_ sender: Any) {
        JobShortlist()
    }
    
    @IBAction func btnApply(_ sender: Any) {
        applyJob()
    }
}
//MARK:- Click action

