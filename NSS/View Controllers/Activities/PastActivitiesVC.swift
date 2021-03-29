//
//  PastActivitiesVC.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit


class PastActivitiesVC: ParentVc {

    @IBOutlet weak var tblView: UITableView!
    var viewModel = ActivitiesListDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchListData()
    }
    
    func fetchListData() {
        
        viewModel.urlFetch = APIConstants.fetchUrl(.freelancer_past_jobsApi)
      
        viewModel.jobListDataFetch(JobListDataRequestModel) { [weak self] (flag) in
            if flag {
                self?.tblView.reloadData()
                if self?.viewModel.numberOfRows == 0 {
                    self?.tblView.isHidden = true
                } else {
                    self?.tblView.isHidden = false
                }
            } else {
                
            }
        }
    }
    
    var JobListDataRequestModel: [String: Any] {
        return [
            "user_id" : UserDefaults.standard.string(forKey: "freelancer_user_id") ?? ""
        ]
    }

}
extension PastActivitiesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as! PastActivitiesTableViewCell
        
        cell.selectionStyle = .none
        cell.data = viewModel.getJobList(index: indexPath.row)
        
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
