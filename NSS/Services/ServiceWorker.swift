/*
 * ServiceWorker
 //  Created by Gowtham on 30/01/21.
 //  Copyright © 2021 com.NSS. All rights reserved.
 */

import Alamofire
import ObjectMapper

public protocol NetworkHandlerProtocol: class {
    func error(staus: Int, message: String)
    var payLoad: [String: Any]? { get set}
    func callAlert(message: String)
}

private var serviceHeader: HTTPHeaders {
    return ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "freelancer_AccessToken")!)",
            "Content-Type": "application/json"]
}

// MARK:- SERVICE CALL
class ServiceWorker: ParentObject {
    
    static func get<T: Mappable>(url: URL,
                                 method: HTTPMethod,
                                 payload: [String: Any]?,
                                 _ shouldLoader: Bool? = true,
                                 closure: @escaping(T) -> Void,
                                 errorHandler: @escaping(AFError) -> Void) {
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: serviceHeader).responseJSON { (responseData) in
            switch responseData.result {
                
            case .success(_):
                let content = String(data: responseData.data ?? Data(), encoding: String.Encoding.utf8)
                let response = Mapper<T>().map(JSONString: content!)
                closure(response!)
                print("Success Response for ==>> ", url)
                break
                
            case .failure(let afError):
                errorHandler(afError as! AFError)
                print("Error Response  ==>> ", responseData.error as Any)
                break
            }
        }
    }
    
    // POST Service
    static func set<T: Mappable>(url: URL,
                                 payload: [String: Any]?,
                                 header: HTTPHeaders? = nil,
                                 _ shouldLoader: Bool? = true,
                                 _ isAccesstoken: Bool = true,
                                 closure: @escaping(T) -> Void,
                                 errorHandler: @escaping(AFError) -> Void) {
        var payLoad = payload
        //let accessToken = isAccesstoken ? "accessToken" : "access_Token"
        //payLoad![accessToken] = ""//UserDefaults().get(key: .parentAccessToken)
        //payLoad!["languageID"] = ""//UserDefaults().get(key: .languageID)
        let jsonData = try! JSONSerialization.data(withJSONObject: payLoad!)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "freelancer_AccessToken")!)","Content-Type": "application/json"]//serviceHeader
        request.httpBody = jsonData
       // request.headers = ["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "freelancer_AccessToken")!)","Content-Type": "application/json"]
        print(["Authorization": "Bearer \(UserDefaults.standard.string(forKey: "freelancer_AccessToken")!)","Content-Type": "application/json"])
        AF.request(request).responseJSON { (responseData) in
            switch responseData.result {
            case .success(_):
                let content = String(data: responseData.data ?? Data(), encoding: String.Encoding.utf8)
                print("Success Response for ==>> ", url)
                //responseData.data?.printJSONs()
                if let JSONString = String(data: responseData.data!, encoding: String.Encoding.utf8) { print(JSONString) }
                let response = Mapper<T>().map(JSONString: content!)
                closure(response!)
                break
            case .failure:
                print("Error Response  ==>> ", responseData.error as Any)
                break
            }
        }
    }
}


