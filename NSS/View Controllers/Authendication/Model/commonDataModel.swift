//
//  commonDataModel.swift
//  NSS
//
//  Created by Gowma on 04/02/21.
//

import ObjectMapper

//MARK:- GetCommon Data List

struct CommonDataModel: Mappable {
    var success : Bool?
    var message : String?
    //var errorCode : String?
    var data : commonDataResponse?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        success <- map["status"]
        message <- map["message"]
        //errorCode <- map["ErrorCode"]
        data <- map["data"]
    }
}

struct commonDataResponse : Mappable {
    var gender : [gender]?
    var skills : [skills]?
    var job_type : [job_type]?
    var user_type : [user_type]?
    var request_status : [request_status]?

    init?(map: Map) { }
    mutating func mapping(map: Map) {
        gender <- map["gender"]
        skills <- map["skills"]
        job_type <- map["job_type"]
        user_type <- map["user_type"]
        request_status <- map["request_status"]
    }
}

struct gender : Mappable {
   
    var gender_id : Int?
    var gender : String?
    var gender_code : String?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        gender_id <- map["gender_id"]
        gender <- map["gender"]
        gender_code <- map["gender_code"]
       
    }
}

struct skills : Mappable {
   
    var skill_id : Int?
    var skill : String?
    var skill_code : String?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        skill_id <- map["skill_id"]
        skill <- map["skill"]
        skill_code <- map["skill_code"]
       
    }
}

struct job_type : Mappable {
   
    var job_type_id : Int?
    var job_type : String?
    var job_type_code : String?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        job_type_id <- map["job_type_id"]
        job_type <- map["job_type"]
        job_type_code <- map["job_type_code"]
       
    }
}

struct user_type : Mappable {
   
    var user_type_id : Int?
    var user_type : String?
    var user_type_code : String?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        user_type_id <- map["user_type_id"]
        user_type <- map["user_type"]
        user_type_code <- map["user_type_code"]
       
    }
}

struct request_status : Mappable {
   
    var status_id : Int?
    var status_code : String?
    var status : String?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        status_id <- map["status_id"]
        status_code <- map["status_code"]
        status <- map["status"]
       
    }
}
