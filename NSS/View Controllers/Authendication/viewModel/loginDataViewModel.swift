//
//  loginDataViewModel.swift
//  NSS
//
//  Created by Gowma on 05/02/21.
//

import UIKit
import Alamofire

class loginDataViewModel: ParentObject {

   // var loginResponse: loginDataResponse?
    //var loginToken: loginDataViewModel
    //var errorMsg : LoginDataModel
    
    
    //MARK:- SERVICE CALL

    
    func loginSubmit(_ payload: [String: Any],
                       completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.loginApi)
        //let url1 = "\(url)2"
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: LoginDataModel) in
            if response.success == true {
                //self?.errorMsg = response
                UserDefaults.standard.set("\(response.userId!)", forKey: "freelancer_user_id")
                UserDefaults.standard.set(response.token, forKey: "freelancer_AccessToken")
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
    
    //MARK:- SERVICE CALL

    
    func loginSubmitClient(_ payload: [String: Any],
                       completion: @escaping completionHandler) {
        let url = APIConstants.fetchUrl(.loginApiClient)
        //let url1 = "\(url)2"
        ServiceWorker.set(url: url, payload: payload, false, false, closure: { [weak self] (response: LoginDataModel) in
            if response.success == true {
                //self?.errorMsg = response
                UserDefaults.standard.set("\(response.userId!)", forKey: "client_user_id")
                UserDefaults.standard.set(response.token, forKey: "client_AccessToken")
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
