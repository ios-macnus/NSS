/*
 * ApiConstansts
 //  Created by Gowtham on 30/01/21.
 //  Copyright © 2021 com.NSS. All rights reserved.
 */
import Alamofire

extension APIConstants {
    // fetch url
    static func fetchUrl(_ path: servicePath, _ payload: Parameters? = nil) -> URL {
        switch path {
        case .childProfiles: return APIConstants.configuration(.childProfiles)
        case .public_typesApi: return APIConstants.configuration(.public_typesApi)

        
        case .country_listApi:
            return APIConstants.configuration(.country_listApi)
        case .state_listApi:
            return APIConstants.configuration(.state_listApi)
        case .addSkilsApi:
            return APIConstants.configuration(.addSkilsApi)
        case .registerApi:
            return APIConstants.configuration(.registerApi)
        case .loginApi:
            return APIConstants.configuration(.loginApi)
        case .loginApiClient:
            return APIConstants.configuration(.loginApiClient)
        case .fb_registerApi:
            return APIConstants.configuration(.fb_registerApi)
        case .fb_loginApi:
            return APIConstants.configuration(.fb_loginApi)
        case .freelancer_profileApi:
            return APIConstants.configuration(.freelancer_profileApi)
        case .freelancer_nearby_jobsApi:
            return APIConstants.configuration(.freelancer_nearby_jobsApi)
        case .freelancer_recommended_jobsApi:
            return APIConstants.configuration(.freelancer_recommended_jobsApi)
        case .freelancer_trending_jobsApi:
            return APIConstants.configuration(.freelancer_trending_jobsApi)
        case .freelancer_favourite_jobsApi:
            return APIConstants.configuration(.freelancer_favourite_jobsApi)
        case .freelancer_ongoing_jobsApi:
            return APIConstants.configuration(.freelancer_ongoing_jobsApi)
        case .freelancer_past_jobsApi:
            return APIConstants.configuration(.freelancer_past_jobsApi)
        case .freelancer_allJobs:
            return APIConstants.configuration(.freelancer_allJobs)
        case .freelancer_recent_jobsApi:
            return APIConstants.configuration(.freelancer_recent_jobsApi)
        case .freelancer_applied_jobsApi:
            return APIConstants.configuration(.freelancer_applied_jobsApi)
        }
    }
    
    // configuring api
    static func configuration(_ path: servicePath, query: [String: String]? = nil) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path.rawValue
        components.setQueryItems(with: query ?? [:])
        return components.url!
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
