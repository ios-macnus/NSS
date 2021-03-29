//
//  ActivitiesListDataViewModel.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit
import Alamofire

class ActivitiesListDataViewModel: ParentObject {
    var jobListData: [jobActivitiesListDataResponse]?
    var urlFetch = APIConstants.fetchUrl(.freelancer_allJobs)
    
    var numberOfRows: Int {
        return jobListData?.count ?? 0
    }
    func getJobList(index: Int) -> jobActivitiesListDataResponse? {
        return jobListData?.safe(at: index) ?? nil
    }
    
    //MARK:- SERVICE CALL
    func jobListDataFetch(_ payload: [String: Any],
                          completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_allJobs)
        ServiceWorker.set(url: urlFetch, payload: payload, false, false, closure: { [weak self] (response: ActivitiesListDataModel) in
            if response.success == true {
                self?.jobListData = response.data
                completion(true)
            } else {
                self?.delegate?.alert(.alertError, response.message ?? unpredictedError)
                completion(false)
            }
        }) { (error: AFError) in
            self.delegate?.alert(.alertError, error.localizedDescription)
            completion(false)
        }
    }
}
