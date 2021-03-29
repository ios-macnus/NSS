//
//  HomeVC.swift
//  NSS
//
//  Created by Gowma on 02/02/21.
//

import UIKit


class HomeVC: ParentVc {
    
    @IBOutlet weak var collView1: UICollectionView!
    @IBOutlet weak var collView2: UICollectionView!
    @IBOutlet weak var collView3: UICollectionView!
    @IBOutlet weak var collView4: UICollectionView!
    @IBOutlet weak var viewShadowBg1: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserInfo: UILabel!
    @IBOutlet weak var lblEarnings: UILabel!
    @IBOutlet weak var lblPending: UILabel!
    @IBOutlet weak var lblSubmission: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewRecomm: UIView!
    @IBOutlet weak var viewTrending: UIView!
    @IBOutlet weak var viewNearJob: UIView!
    @IBOutlet weak var viewLatestJob: UIView!
    var viewModel = dashboardDataViewModel()
    var viewModelJobRecom = JobListDataViewModel1()
    var viewModelJobTrend = JobListDataViewModel2()
    var viewModelJobNear = JobListDataViewModel3()
    var viewModelJobLatest = JobListDataViewModel4()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        viewShadowBg1.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        viewShadowBg1.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        viewShadowBg1.layer.shadowOpacity = 0.5
        viewShadowBg1.layer.shadowRadius = 3.0
        viewShadowBg1.layer.masksToBounds = false
        viewShadowBg1.layer.cornerRadius = 0.0
        print(UserDefaults.standard.string(forKey: "freelancer_user_id")!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchListData()
    }
    
    func fetchListData() {
        
        
        showOnViewTwins()
        
        viewModel.dashProfileDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.lblName.text = self?.viewModel.dashboardProfileResponse?.profile?.name
                self?.lblUserInfo.text = self?.viewModel.dashboardProfileResponse?.profile?.about_me
                self?.lblEarnings.text = "$ " + String(self?.viewModel.dashboardProfileResponse?.profile?.total_earnings ?? 0)
                self?.lblPending.text = "$ " + String(self?.viewModel.dashboardProfileResponse?.profile?.amount_pending ?? 0)
                self?.lblSubmission.text = String(self?.viewModel.dashboardProfileResponse?.profile?.application_submitted ?? 0)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                let date = dateFormatter.date(from: self?.viewModel.dashboardProfileResponse?.profile?.registered_on ?? "2021-01-01T00:00:00.000Z")
                dateFormatter.dateFormat = "dd MMM yyyy"
                
                self?.lblDate.text = "Joined " + "\(dateFormatter.string(from: date!))" //String(self?.viewModel.dashboardProfileResponse?.profile?.registered_on ?? "")
                //self?.collView.reloadData()
                //print("-----")
                //print(self?.viewModel.bannerResponse?.gender ?? "")
                
                 self?.hideLoadingHub()
                self?.fetchRecommListData()
            } else {
               
                 self?.hideLoadingHub()
            }
        }
    }
    
    func fetchRecommListData() {

        
        showOnViewTwins()
        
        viewModelJobRecom.jobListDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.collView1.reloadData()
                 self?.hideLoadingHub()
                if self?.viewModelJobRecom.numberOfRows1 == 0 {
                    self?.collView1.isHidden = true
                    self?.viewRecomm.isHidden = true
                } else {
                    self?.collView1.isHidden = false
                    self?.viewRecomm.isHidden = false
                }
                self?.fetchTrendListData()
            } else {
                
                 self?.hideLoadingHub()
            }
        }
    }
    
    func fetchTrendListData() {
        
        viewModelJobTrend.jobListDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.collView2.reloadData()
                if self?.viewModelJobTrend.numberOfRows2 == 0 {
                    self?.collView2.isHidden = true
                    self?.viewTrending.isHidden = true
                } else {
                    self?.collView2.isHidden = false
                    self?.viewTrending.isHidden = false
                }
                self?.fetchNearListData()
            }
        }
    }
    
    func fetchNearListData() {
        
        viewModelJobNear.jobListDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.fetchLatListData()
                if self?.viewModelJobNear.numberOfRows3 == 0 {
                    self?.collView3.isHidden = true
                    self?.viewNearJob.isHidden = true
                } else {
                    self?.collView3.isHidden = false
                    self?.viewNearJob.isHidden = false
                }
                self?.collView3.reloadData()
            }
        }
    }
    
    func fetchLatListData() {
        
        viewModelJobLatest.jobListDataFetch(dashboardDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.collView4.reloadData()
                if self?.viewModelJobLatest.numberOfRows4 == 0 {
                    self?.collView4.isHidden = true
                    self?.viewLatestJob.isHidden = true
                } else {
                    self?.collView4.isHidden = false
                    self?.viewLatestJob.isHidden = false
                }
            }
        }
    }
    
    
    var dashboardDataRequestModel: [String: Any] {
        return [
            "user_id" : UserDefaults.standard.string(forKey: "freelancer_user_id") ?? ""
            
            //"Email": UserDefaults().get(key: .email) as Any
        ]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnList(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            payLoad = ["selTitle": "Recommended Jobs"]
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.payLoad = payLoad

            self.present(nextVC , animated: false, completion: nil)
            break
        case 2:
            payLoad = ["selTitle": "Trending Jobs"]
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.payLoad = payLoad
            self.present(nextVC , animated: false, completion: nil)
            break
        case 3:
            payLoad = ["selTitle": "Jobs Near You"]
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.payLoad = payLoad
            self.present(nextVC , animated: false, completion: nil)
            break
        case 4:
            payLoad = ["selTitle": "Latest Jobs"]
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobListVC") as! JobListVC
            nextVC.modalPresentationStyle = .fullScreen
            nextVC.payLoad = payLoad
            self.present(nextVC , animated: false, completion: nil)
            break
        default:
            break
        }
    }
    @IBAction func btnProfileView(_ sender: Any) {
       // self.goToPresent(self, storyBoard: .dashboard, id: .settingsTabVC, payLoad: payLoad)
        payLoad = ["selFrom": "Home"]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "SettingsTabVC") as! SettingsTabVC
        nextVC.modalPresentationStyle = .fullScreen
        nextVC.payLoad = payLoad
        self.present(nextVC , animated: false, completion: nil)
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collView1 {
            return viewModelJobRecom.numberOfRows1
        } else  if collectionView == collView2 {
            return viewModelJobTrend.numberOfRows2
        } else  if collectionView == collView3 {
            return viewModelJobNear.numberOfRows3
        }
        return viewModelJobLatest.numberOfRows4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collView1 {
            let cell = collView1.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecomJobCollectionViewCell
            
            cell.viewBg.layer.borderWidth = 0.5
            cell.viewBg.layer.borderColor = UIColor.black.cgColor
          
            cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            cell.viewBg.layer.shadowOpacity = 0.5
            cell.viewBg.layer.shadowRadius = 3.0
            cell.viewBg.layer.masksToBounds = false
            cell.viewBg.layer.cornerRadius = 0.0
            
           /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
            let data = viewModelJobRecom.getJobList1(index: indexPath.row)
            cell.lblTitle.text = data?.job_title
            cell.lblClientName.text = data?.client_user_name
            cell.lblClientRating.text = ""
            cell.lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
            cell.lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: data?.job_post_created_on ?? "2021-01-01T00:00:00.000Z")
            dateFormatter.dateFormat = "dd MMM yyyy"
            cell.lblPostDate.text = "\(dateFormatter.string(from: date!))"
            let is_favouriteT = data?.is_favourite
            if(is_favouriteT == true) {
                cell.imgFav.image = UIImage.init(named: "heart_fill")
            } else {
                cell.imgFav.image = UIImage.init(named: "Favourite")
            }
            return cell
            
        } else if collectionView == collView2 {
            let cell = collView2.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TrendingCollectionViewCell
            
            cell.viewBg.layer.borderWidth = 0.5
            cell.viewBg.layer.borderColor = UIColor.black.cgColor
          
            cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            cell.viewBg.layer.shadowOpacity = 0.5
            cell.viewBg.layer.shadowRadius = 3.0
            cell.viewBg.layer.masksToBounds = false
            cell.viewBg.layer.cornerRadius = 0.0
            
           /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
            let data = viewModelJobTrend.getJobList2(index: indexPath.row)
            cell.lblTitle.text = data?.job_title
            cell.lblClientName.text = data?.client_user_name
            cell.lblClientRating.text = ""
            cell.lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
            cell.lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: data?.job_post_created_on ?? "2021-01-01T00:00:00.000Z")
            dateFormatter.dateFormat = "dd MMM yyyy"
            cell.lblPostDate.text = "\(dateFormatter.string(from: date!))"
            let is_favouriteT = data?.is_favourite
            if(is_favouriteT == true) {
                cell.imgFav.image = UIImage.init(named: "heart_fill")
            } else {
                cell.imgFav.image = UIImage.init(named: "Favourite")
            }
            
            return cell
            
        } else if collectionView == collView3 {
            let cell = collView3.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NearJobCollectionViewCell
            
            cell.viewBg.layer.borderWidth = 0.5
            cell.viewBg.layer.borderColor = UIColor.black.cgColor
          
            cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            cell.viewBg.layer.shadowOpacity = 0.5
            cell.viewBg.layer.shadowRadius = 3.0
            cell.viewBg.layer.masksToBounds = false
            cell.viewBg.layer.cornerRadius = 0.0
            
           /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
            let data = viewModelJobNear.getJobList3(index: indexPath.row)
            cell.lblTitle.text = data?.job_title
            cell.lblClientName.text = data?.client_user_name
            cell.lblClientRating.text = ""
            cell.lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
            cell.lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = dateFormatter.date(from: data?.job_post_created_on ?? "2021-01-01T00:00:00.000Z")
            dateFormatter.dateFormat = "dd MMM yyyy"
            cell.lblPostDate.text = "\(dateFormatter.string(from: date!))"
            let is_favouriteT = data?.is_favourite
            if(is_favouriteT == true) {
                cell.imgFav.image = UIImage.init(named: "heart_fill")
            } else {
                cell.imgFav.image = UIImage.init(named: "Favourite")
            }
            
            return cell
        }
        let cell = collView4.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LatestJobCollectionViewCell
        
        cell.viewBg.layer.borderWidth = 0.5
        cell.viewBg.layer.borderColor = UIColor.black.cgColor
      
        cell.viewBg.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        cell.viewBg.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        cell.viewBg.layer.shadowOpacity = 0.5
        cell.viewBg.layer.shadowRadius = 3.0
        cell.viewBg.layer.masksToBounds = false
        cell.viewBg.layer.cornerRadius = 0.0
        
       /* cell.imgTitle.sd_setImage(with: NSURL(string: "\(imgT)") as URL?, placeholderImage:UIImage(named:"imgT4"))*/
        let data = viewModelJobLatest.getJobList4(index: indexPath.row)
        cell.lblTitle.text = data?.job_title
        cell.lblClientName.text = data?.client_user_name
        cell.lblClientRating.text = ""
        cell.lblInfo.text = "\(data?.job_requirement ?? "") | \(data?.city_name ?? "")"
        cell.lblAmount.text = "$\(data?.job_price ?? 0) | \(data?.client_user_name ?? "")"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: data?.job_post_created_on ?? "2021-01-01T00:00:00.000Z")
        dateFormatter.dateFormat = "dd MMM yyyy"
        cell.lblPostDate.text = "\(dateFormatter.string(from: date!))"
        let is_favouriteT = data?.is_favourite
        if(is_favouriteT == true) {
            cell.imgFav.image = UIImage.init(named: "heart_fill")
        } else {
            cell.imgFav.image = UIImage.init(named: "Favourite")
        }
        
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
        if collectionView == collView1 {
            let client_job_post_idT = viewModelJobRecom.getJobList1(index: indexPath.row)?.client_job_post_id
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobDetailsMainVC") as! JobDetailsMainVC
            nextVC.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set("\(client_job_post_idT ?? 0)", forKey: "Job_Id_Pass")
            self.present(nextVC , animated: false, completion: nil)
        } else if collectionView == collView2 {
            let client_job_post_idT = viewModelJobTrend.getJobList2(index: indexPath.row)?.client_job_post_id
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobDetailsMainVC") as! JobDetailsMainVC
            nextVC.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set("\(client_job_post_idT ?? 0)", forKey: "Job_Id_Pass")
            self.present(nextVC , animated: false, completion: nil)
        } else if collectionView == collView3 {
            let client_job_post_idT = viewModelJobNear.getJobList3(index: indexPath.row)?.client_job_post_id
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobDetailsMainVC") as! JobDetailsMainVC
            nextVC.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set("\(client_job_post_idT ?? 0)", forKey: "Job_Id_Pass")
            self.present(nextVC , animated: false, completion: nil)
        } else if collectionView == collView4 {
            let client_job_post_idT = viewModelJobLatest.getJobList4(index: indexPath.row)?.client_job_post_id
            let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
            let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobDetailsMainVC") as! JobDetailsMainVC
            nextVC.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set("\(client_job_post_idT ?? 0)", forKey: "Job_Id_Pass")
            self.present(nextVC , animated: false, completion: nil)
        } else {
            
        }
        
       
        //self.goToPresent(self, storyBoard: .jobList, id: .jobDetailsMainVC, payLoad: payLoad)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        if collectionView == collView1 {
            return CGSize(width: 240, height: 164)
        } else if collectionView == collView2 {
            let width  = (collView1.frame.width-30)/2
            return CGSize(width: width, height: 164)
        } else if collectionView == collView3 {
            return CGSize(width: 240, height: 164)
        }
        let width  = (collView1.frame.width-30)/2
        return CGSize(width: width, height: 164)
    }

}
