//
//  CPostJobListVC.swift
//  NSS
//
//  Created by Gowma on 21/03/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CPostJobListVC: ParentVc {

    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var roundedView1: UIView!
    @IBOutlet weak var roundedView2: UIView!
    @IBOutlet weak var roundedView3: UIView!
    @IBOutlet weak var roundedView4: UIView!
    var arrTitle = ["Movers","Cleaners","Aircon Service","Electrician","Handyman","Plumber"]
    var arrImage = ["imgs1","imgs2","imgs3","imgs4","imgs5","imgs6"]
    var collCount = 0
    var arrSecDashFor = [[String:AnyObject]]()
    var selIndex = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundedView1.makeCircular()
        roundedView2.makeCircular()
        roundedView3.makeCircular()
        roundedView4.makeCircular()
        //getPostedJobDetails()
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
                         self.collCount = self.arrSecDashFor.count
                         self.collView.reloadData()
                        if(self.collCount == 0) {
                            self.collView.isHidden = true
                        } else {
                            self.collView.isHidden = false
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
    
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if(selIndex == 1000) {
            self.view.makeToast("Please Select Category", duration: 3.0, position: .bottom)
        } else {
            
            //let dictBaseT = self.arrSecDashFor[selIndex]
            //let jobIdT = "\(dictBaseT["client_job_post_id"]!)"
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "ClientPostJob", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "CPostJobAddDetailsVC") as! CPostJobAddDetailsVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.arrSecDashForB = arrSecDashFor
            self.present(nextVC , animated: false, completion: nil)
        }
        
    }
    //CPostJobListCollectionViewCell
}
extension CPostJobListVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTitle.count//collCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CPostJobListCollectionViewCell
        
       // let dictBaseT = self.arrSecDashFor[indexPath.row]
       // cell.lblTitle.text = "\(dictBaseT["job_title"]!)"
        if(selIndex == indexPath.row) {
            cell.viewSelect.isHidden = false
        } else {
            cell.viewSelect.isHidden = true
        }
        cell.lblTitle.text = arrTitle[indexPath.row]
        cell.imgUser.image = UIImage.init(named: arrImage[indexPath.row])
        
       /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//
//        cell.alpha = 0
//        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
//        UIView.animate(withDuration: 0.4, animations: { () -> Void in
//            cell.alpha = 1
//            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
//        })
//    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(selIndex == indexPath.row) {
            selIndex = 1000
        } else {
            selIndex = indexPath.row
        }
        collView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

        let width  = (collView.frame.width-10)/2
        return CGSize(width: width, height: 150)
    }

}
