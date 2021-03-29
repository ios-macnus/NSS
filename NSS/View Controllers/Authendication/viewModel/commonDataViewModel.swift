//
//  commonDataViewModel.swift
//  NSS
//
//  Created by Gowma on 04/02/21.
//

import UIKit
import Alamofire

class commonDataViewModel: ParentObject {

    var bannerResponse: commonDataResponse?
    
    
    //MARK:- SERVICE CALL
    // GetGender and Skills
    
    func fetchCommonData(_ payload: [String: Any],
                       completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.public_typesApi)
        ServiceWorker.get(url: url, method:.get , payload: [:], false, closure: { [weak self] (response: CommonDataModel) in
            print(url)
            print(response)
            if response.success == true {
                self?.bannerResponse = response.data
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
