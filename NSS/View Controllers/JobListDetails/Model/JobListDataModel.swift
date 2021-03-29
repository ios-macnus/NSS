//
//  JobListDataModel.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import UIKit
import ObjectMapper

struct JobListDataModel: Mappable {
    var success : Bool?
    var message : String?
    var data : [jobListDataResponse]?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        success <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}

struct jobListDataResponse : Mappable {
    
    var client_job_post_id : Int?
    var job_title : String?
    var job_starts_from : String?
    var job_ends_on : String?
    var job_highlights : String?
    var job_overview : String?
    var job_requirement : String?
    var job_post_created_on : String?
    var job_city_id : Int?
    var city_name : String?
    var job_type_id : Int?
    var job_type : String?
    var job_price : Int?
    var is_job_assigned : String?
    var client_user_name : String?
    var client_user_id : Int?
    var is_favourite : Bool?
    var is_applied : String?
    var request_progress_id : Int?
    var skills : String?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        client_job_post_id <- map["client_job_post_id"]
        job_title <- map["job_title"]
        job_starts_from <- map["job_starts_from"]
        job_ends_on <- map["job_ends_on"]
        job_highlights <- map["job_highlights"]
        job_overview <- map["job_overview"]
        job_requirement <- map["job_requirement"]
        job_post_created_on <- map["job_post_created_on"]
        job_city_id <- map["job_city_id"]
        city_name <- map["city_name"]
        job_type_id <- map["job_type_id"]
        job_type <- map["job_type"]
        job_price <- map["job_price"]
        is_job_assigned <- map["is_job_assigned"]
        client_user_name <- map["client_user_name"]
        client_user_id <- map["client_user_id"]
        is_favourite <- map["is_favourite"]
        is_applied <- map["is_applied"]
        request_progress_id <- map["request_progress_id"]
        skills <- map["skills"]
    }
}

