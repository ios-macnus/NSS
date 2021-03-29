//
//  DashboardDataViewModel.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit
import Alamofire

class dashboardDataViewModel: ParentObject {

    var dashboardProfileResponse: dashboardProfileDataResponse?
    
    
    //MARK:- SERVICE CALL
    func dashProfileDataFetch(_ payload: [String: Any],
                       completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.freelancer_profileApi)
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: DashboardDataModel) in
            if response.success == true {
                //self?.errorMsg = response
                self?.dashboardProfileResponse = response.data
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

