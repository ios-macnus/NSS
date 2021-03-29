//
//  CSearchResultsListVC.swift
//  NSS
//
//  Created by Gowthaman Anandakumar on 29/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CSearchResultsListVC: ParentVc {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    var tblCount = 0
    var arrSecDashFor = [[String:AnyObject]]()
    var searchStringB = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPostedJobDetails()
    }
    
    func getPostedJobDetails() {
          //ANLoader.showLoading("Loading", disableUI: false)
          //ANLoader.activityBackgroundColor = UIColor(red: 0.32, green: 0.71, blue: 0.45, alpha: 1.00)
         
         let userIdT = UserDefaults.standard.string(forKey: "client_user_id")
         let accessTokenT = UserDefaults.standard.string(forKey: "client_AccessToken")
         
        let headers: HTTPHeaders = ["Authorization" : "Bearer \(accessTokenT ?? "")",
         "Content-Type": "application/json"]
          
         
         let param: [String: Any] = ["user_id" : userIdT!]
          
          //"\(demourl)dashboard.php"
          AF.request("http://sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com/api/jobPosts/client/search/\(searchStringB)",method:.post, parameters: nil , encoding:  JSONEncoding.default, headers: headers).responseJSON {(responseData) -> Void in
              
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

  

}
extension CSearchResultsListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblCount//viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! CSearchResultsListTableViewCell
        
        cell.selectionStyle = .none

        let dictBaseT = self.arrSecDashFor[indexPath.row]
        cell.lblTitle.text = "\(dictBaseT["job_title"]!)"
        cell.lblClientName.text = "\(dictBaseT["job_requirement"]!)"
        cell.lblInfo.text = "\(dictBaseT["city_name"]!)"
        cell.lblAmount.text = "Job Price $\(dictBaseT["job_price"]!) | Fixed Price"
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
//        let date = dateFormatter.date(from: "\(dictBaseT["job_starts_from"]!)")
//        dateFormatter.dateFormat = "dd MMM yyyy"
        
       // cell.lblDateOfWork.text = "Date of work  \(dateFormatter.string(from: date!))"
        //cell.lblJobCompleteDate.text = "\(dictBaseT["job_title"]!)"
        //cell.data = viewModel.getJobList(index: indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
}
