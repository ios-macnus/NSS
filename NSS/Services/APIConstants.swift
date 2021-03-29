//
//  AppConstants.swift
//  GyroscopePOC
//
//  Created by Gowtham on 30/01/21.
//  Copyright © 2021 com.NSS. All rights reserved.
//

import UIKit
///UUID
let uuid = UUID().uuidString
/// User name
let userName = UIDevice.current.name

struct APIConstants {
    /// scheme
    static let scheme = "http"
    /// host
    //static let host = "staging.plano.co"
    static let host = "sampleapp-env.eba-xbpbgrv3.ap-southeast-2.elasticbeanstalk.com"
}

//
// PATHS
//
enum servicePath: String {
    //Common
    case public_typesApi = "/api/public/public_types"
    case country_listApi = "/api/public/country"
    case state_listApi = "/api/public/state/"
    case addSkilsApi = "/api/jobPosts/freelancer/AddSkills"
    
    //Onboarding
    case registerApi = "/api/auth/register/"
    case loginApi = "/api/auth/login/2"
    case loginApiClient = "/api/auth/login/3"
    case fb_registerApi = "/api/auth/fb/register/"
    case fb_loginApi = "/api/auth/fb/login/"
    
    //FreeLauncher Dashboard
    case freelancer_allJobs = "/api/jobPosts/freelancer/all_jobs"
    case freelancer_profileApi = "/api/jobPosts/freelancer/profile"
    
    case freelancer_recommended_jobsApi = "/api/jobPosts/freelancer/recommended_jobs"
    case freelancer_trending_jobsApi = "/api/jobPosts/freelancer/trending_jobs"
    case freelancer_nearby_jobsApi = "/api/jobPosts/freelancer/nearby_jobs/"
    case freelancer_recent_jobsApi = "/api/jobPosts/freelancer/recent_jobs"

    //FreeLauncher Activities
    case freelancer_ongoing_jobsApi = "/api/jobPosts/freelancer/ongoing_jobs"
    case freelancer_past_jobsApi = "/api/jobPosts/freelancer/past_jobs"
    case freelancer_applied_jobsApi = "/api/jobPosts/freelancer/applied_jobs"
    case freelancer_favourite_jobsApi = "/api/jobPosts/freelancer/favourite_jobs"
    
    //FreeLauncher Dashboard
    //case freelancer_nearby_jobsApi = "/api/jobPosts/freelancer/job_details/"
   // case freelancer_profile = "/api/jobPosts/freelancer/profile"
    
    // Parent
    case childProfiles = "/planoapi/V1/Parent/ChildProfiles"
    //case loginApi = "accounts/authenticate"

}
