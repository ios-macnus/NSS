//
//  CRejectedJobApplicationsVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CRejectedJobApplicationsVC: ParentVc {

    @IBOutlet weak var tblView: UITableView!
    var tblCount = 0
    var arrSecDashFor = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPostedJobDetails()
        NotificationCenter.default.addObserver(self,selector: #selector(self.afterRejectReload),name: NSNotification.Name(rawValue: "afterRejectReload"),object: nil)
    }
    
    @objc private func afterRejectReload() {
        getPostedJobDetails()
        
    }
    
    
    func getPostedJobDetails() {
          //ANLoader.showLoading("Loading", disableUI: false)
          //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
         
         let userIdT = UserDefaults.standard.string(forKey: "client_user_id")
         let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
        let jobId = UserDefaults.standard.string(forKey: "Job_Id_Pass")!
        
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
         "Content-Type": "application/json"]
          
         
         let param: [String: Any] = ["job_id" : Int(jobId)!]
         print(param)
          print("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/specific_job/rejected")
          //"\(demourl)dashboard.php"
          AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/specific_job/rejected",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
              
              switch responseData.result {
              case .success(let value):
                  let swiftyJsonVar = JSON(value)
                  print(swiftyJsonVar)
                  if let resData = swiftyJsonVar[].dictionaryObject {
                      let status = (resData)["status"] as! Bool
                      //let message = (resData)["message"] as! String
                      if status {
                        self.arrSecDashFor = ((resData)["data"] as! [[String:AnyObject]])
                         self.tblCount = self.arrSecDashFor.count
                         self.tblView.reloadData()
                        if(self.tblCount == 0){
                            self.tblView.isHidden = true
                        } else {
                            self.tblView.isHidden = false
                        }
                      }
                      
                      //ANLoader.hide()
                  }
              case .failure(let error):
                  print(error)
                  //ANLoader.hide()
              }
            
          }

    }
    
    @objc func getPostedReject(sender: UIButton){
        let buttonTag = sender.tag
        let dictBaseT = self.arrSecDashFor[buttonTag]
        let client_user_idT = "\(dictBaseT["client_user_id"]!)"
        let request_progress_idT = "\(dictBaseT["request_progress_id"]!)"
        let freelancer_user_idT = "\(dictBaseT["freelancer_user_id"]!)"
        let client_job_post_idT = "\(dictBaseT["client_job_post_id"]!)"
        
       let userIdT = UserDefaults.standard.string(forKey: "client_user_id")!
        let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
       let jobId = UserDefaults.standard.string(forKey: "Job_Id_Pass")!
       let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
        "Content-Type": "application/json"]
         
       let param: [String: Any] = ["status_code":"REJECT",
                                   "client_user_id":Int(client_user_idT)!,
                                   "request_progress_id":Int(request_progress_idT)!,
                                   "freelancer_user_id":Int(freelancer_user_idT)!,
                                   "client_job_post_id":Int(client_job_post_idT)!]
         print(param)
       
       print("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/update/jobstatus")
         //"\(demourl)dashboard.php"
         AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/update/jobstatus",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
             
             switch responseData.result {
             case .success(let value):
                 let swiftyJsonVar = JSON(value)
                 print(swiftyJsonVar)
                 if let resData = swiftyJsonVar[].dictionaryObject {
                     let status = (resData)["status"] as! Bool
                     //let message = (resData)["message"] as! String
                   self.getPostedJobDetails()
                     //ANLoader.hide()
                 }
             case .failure(let error):
                 print(error)
                 //ANLoader.hide()
             }
           
         }
    }
    

}

extension CRejectedJobApplicationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! CRejectedJobTableViewCell
        cell.selectionStyle = .none
        //cell.data = viewModel.getJobList(index: indexPath.row)
        let dictBaseT = self.arrSecDashFor[indexPath.row]
        cell.lblTitle.text = "\(dictBaseT["freelancer_name"]!)"
        cell.lblDesc.text = "\(dictBaseT["city_name"]!)"
        cell.lblRating.text = "\(dictBaseT["rating_count"]!)"
        //cell.lblJobTitle.text = "\(dictBaseT["job_overview"]!)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: "\(dictBaseT["date_of_birth"]!)")
        dateFormatter.dateFormat = "dd MMM yyyy"
        cell.lblDate.text = "\(dateFormatter.string(from: date!))"
        
        cell.btnReject.tag = indexPath.row
        cell.btnReject.addTarget(self, action: #selector(getPostedReject(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.goToPresent(self, storyBoard: .jobList, id: .jobDetailsMainVC, payLoad: payLoad)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "ClientApplication", bundle: nil)
//        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ClientApplicationMainVC") as! ClientApplicationMainVC
//        nextVC.modalPresentationStyle = .fullScreen
//        self.present(nextVC , animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
