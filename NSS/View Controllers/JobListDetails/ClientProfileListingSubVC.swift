//
//  ClientProfileListingSubVC.swift
//  NSS
//
//  Created by Gowma on 12/03/21.
//

import UIKit


class ClientProfileListingSubVC: ParentVc {
    
    @IBOutlet weak var collView: UICollectionView!
    var viewModelJobRecom = JobListDataViewModel2()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       fetchRecommListData()
    }
    

    func fetchRecommListData() {

        
        showOnViewTwins()
        
        viewModelJobRecom.jobListDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.collView.reloadData()
                 self?.hideLoadingHub()
                if self?.viewModelJobRecom.numberOfRows2 == 0 {
                    self?.collView.isHidden = true
                } else {
                    self?.collView.isHidden = false
                }
            } else {
                
                 self?.hideLoadingHub()
            }
        }
    }

    var dashboardDataRequestModel: [String: Any] {
        return [
            "user_id" : UserDefaults.standard.string(forKey: "freelancer_user_id") ?? ""
            
            //"Email": UserDefaults().get(key: .email) as Any
        ]
    }

    

}
extension ClientProfileListingSubVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelJobRecom.numberOfRows2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClientProfileListingSubCollectionViewCell
        
        cell.viewBg.layer.borderWidth = 0.5
        cell.viewBg.layer.borderColor = UIColor.black.cgColor
      
        cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        cell.viewBg.layer.shadowOpacity = 0.5
        cell.viewBg.layer.shadowRadius = 3.0
        cell.viewBg.layer.masksToBounds = false
        cell.viewBg.layer.cornerRadius = 0.0
        
       /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
        let data = viewModelJobRecom.getJobList2(index: indexPath.row)
        cell.lblTitle.text = data?.job_title
        cell.lblClientName.text = data?.client_user_name
        cell.lblClientRating.text = ""
        cell.lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
        cell.lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
        cell.lblPostDate.text = data?.job_post_created_on
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 0.5)
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            cell.alpha = 1
            cell.layer.transform = CATransform3DScale(CATransform3DIdentity, 1, 1, 1)
        })
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width  = (collView.frame.width-20)/2
        return CGSize(width: width, height: 164)
    }

}
