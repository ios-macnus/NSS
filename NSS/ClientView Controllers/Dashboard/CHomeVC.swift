//
//  CHomeVC.swift
//  NSS
//
//  Created by Gowma on 15/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CHomeVC: ParentVc {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var imgClient: UIImageView!
    @IBOutlet weak var lblClientName: UILabel!
    @IBOutlet weak var lblClientInfo: UILabel!
    @IBOutlet weak var lblClientRating: UILabel!
    @IBOutlet weak var lblRatingNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var tblCount = 0
    var arrSecDashFor = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {

        getProfileDetails()
    }
    
    func getProfileDetails() {
        showOnViewTwins()
         
         let userIdT = UserDefaults.standard.string(forKey: "client_user_id")
         let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
         
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
         "Content-Type": "application/json"]
          
         
         let param: [String: Any] = ["user_id" : userIdT!]
          print("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/profile_view")
        print(param)
          //"\(demourl)dashboard.php"
          AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/profile_view",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
              
              switch responseData.result {
              case .success(let value):
                  let swiftyJsonVar = JSON(value)
                  print(swiftyJsonVar)
                  if let resData = swiftyJsonVar[].dictionaryObject {
                      let status = (resData)["status"] as! Bool
                      //let message = (resData)["message"] as! String
                      if status {
                         let client_DetailsT = (resData)["data"] as! NSDictionary
                        self.lblClientName.text = "\(client_DetailsT["full_name"] ?? "")"
                        self.lblClientInfo.text = "\(client_DetailsT["state_name"] ?? "")" + " | " + "\(client_DetailsT["city_name"] ?? "")"
                        self.lblClientRating.text = "\(client_DetailsT["rating"]!)"
                        self.lblRatingNo.text = "\(client_DetailsT["rating_count"]!)"
                                    let photo_profile_urlT = "\(client_DetailsT["rating_count"]!)"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                        let date = dateFormatter.date(from: "\(client_DetailsT["joined_date"]!)")
                        dateFormatter.dateFormat = "dd MMM yyyy"
                        
                        self.lblDate.text = "Joined on" + "\(dateFormatter.string(from: date!))"
                      }
                    self.getPostedJobDetails()

                    self.hideLoadingHub()
                  }
              case .failure(let error):
                  print(error)
                self.hideLoadingHub()
              }
              
            
          }

    }
    
    func getPostedJobDetails() {
          //ANLoader.showLoading("Loading", disableUI: false)
          //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
         
         let userIdT = UserDefaults.standard.string(forKey: "client_user_id")
         let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
         
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
         "Content-Type": "application/json"]
          
         
         let param: [String: Any] = ["user_id" : userIdT!]
        print("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/posted_jobs")
        print(param)
          //"\(demourl)dashboard.php"
          AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/posted_jobs",method:.post, parameters: param , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
              
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
                        if(self.tblCount == 0) {
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
    
    @IBAction func btnPostJob(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ClientPostJob", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CPostJobListVC") as! CPostJobListVC
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC , animated: false, completion: nil)
    }
    @IBAction func btnProfile(_ sender: Any) {
        payLoad = ["selFrom": "Home"]
        let storyBoard: UIStoryboard = UIStoryboard(name: "ClientDashboard", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CSettingsVC") as! CSettingsVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.payLoad = payLoad
        self.present(nextVC , animated: false, completion: nil)
    }
    
}
extension CHomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! CHomeTableViewCell
        cell.selectionStyle = .none
        let dictBaseT = self.arrSecDashFor[indexPath.row]
        cell.lblTitle.text = "\(dictBaseT["job_title"]!)"
        cell.lblInfo1.text = "\(dictBaseT["city_name"]!)"
        cell.lblInfo2.text = "\(dictBaseT["job_overview"]!)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: "\(dictBaseT["job_starts_from"]!)")
        dateFormatter.dateFormat = "dd MMM yyyy"
        cell.lblDate.text = "Posted on  \(dateFormatter.string(from: date!))"
        
        //let titleT = dictBaseT["vehicle_no"] as! String
        //let imgT = dictBaseT["vehicle_image"]!
        /*
         "job_requirement" : "Professional ",
         "job_overview" : "End to End",
         "job_title" : "Mover",
         "client_job_post_id" : 18,
         "job_highlights" : "Highlights",
         "job_starts_from" : "2021-03-15T00:00:00.000Z",
         "job_ends_on" : "2021-03-25T00:00:00.000Z",
         "job_type_id" : 1,
         "job_type" : "Male",
         "job_city_id" : 1,
         "job_price" : 120,
         "skills" : "Female,Male",
         "city_name" : "11Wellington",
         "is_job_assigned" : null,
         "request_progress_id" : 21,
         "job_post_created_on" : "2021-03-15T13:46:36.000Z"
         */
        //cell.data = viewModel.getJobList(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.goToPresent(self, storyBoard: .jobList, id: .jobDetailsMainVC, payLoad: payLoad)
        
        let dictBaseT = self.arrSecDashFor[indexPath.row]
     
        let storyBoard: UIStoryboard = UIStoryboard(name: "ClientApplication", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "ClientApplicationMainVC") as! ClientApplicationMainVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.strJobTitleB = "\(dictBaseT["job_title"]!)"
        nextVC.strJobInfo1 = "\(dictBaseT["city_name"]!)"
        nextVC.strJobDate = "\(dictBaseT["job_ends_on"]!)"
        nextVC.strJobPost = "\(dictBaseT["job_post_created_on"]!)"
        nextVC.strPrice = "\(dictBaseT["job_price"]!)"
        UserDefaults.standard.set("\(dictBaseT["client_job_post_id"]!)", forKey: "Job_Id_Pass")
    
        self.present(nextVC , animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
