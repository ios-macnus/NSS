//
//  JobListVC.swift
//  NSS
//
//  Created by Gowma on 18/02/21.
//

import UIKit


class JobListVC: ParentVc {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var strTitle = ""
    override var payLoad: [String : Any]? {
        didSet {
            if let titleB = payLoad?["selTitle"] as? String {
                self.strTitle = titleB
            }
        }
    }
    
    var viewModel = JobListDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = strTitle
        fetchListData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchListData()
    }
    
    func fetchListData() {
        switch strTitle {
        case Constant.Rec_job:
            viewModel.urlFetch = APIConstants.fetchUrl(.freelancer_recommended_jobsApi)
            break
        case Constant.Tren_job:
            viewModel.urlFetch = APIConstants.fetchUrl(.freelancer_trending_jobsApi)
            break
        case Constant.Near_job:
            viewModel.urlFetch = APIConstants.fetchUrl(.freelancer_nearby_jobsApi)
            break
        case Constant.Lat_job:
            viewModel.urlFetch = APIConstants.fetchUrl(.freelancer_recent_jobsApi)
            break
        default:
            break
        }
        
        showOnViewTwins()
        
        viewModel.jobListDataFetch(JobListDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.tblView.reloadData()
                if self?.viewModel.numberOfRows == 0 {
                    self?.tblView.isHidden = true
                } else {
                    self?.tblView.isHidden = false
                }
                 self?.hideLoadingHub()
            } else {
                
                 self?.hideLoadingHub()
            }
        }
    }
    
    var JobListDataRequestModel: [String: Any] {
        return [
            "user_id" : UserDefaults.standard.string(forKey: "freelancer_user_id") ?? ""
        ]
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dissmiss()
    }
    
}

extension JobListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! JobListTableViewCell
        cell.selectionStyle = .none
        cell.data = viewModel.getJobList(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client_job_post_idT = viewModel.getJobList(index: indexPath.row)?.client_job_post_id
        let storyBoard: UIStoryboard = UIStoryboard(name: "JobList", bundle: nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "JobDetailsMainVC") as! JobDetailsMainVC
        nextVC.modalPresentationStyle = .fullScreen
        UserDefaults.standard.set("\(client_job_post_idT ?? 0)", forKey: "Job_Id_Pass")
        self.present(nextVC , animated: false, completion: nil)
        //self.goToPresent(self, storyBoard: .jobList, id: .jobDetailsMainVC, payLoad: payLoad)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
