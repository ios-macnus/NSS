//
//  LoginDataModel.swift
//  NSS
//
//  Created by Gowma on 05/02/21.
//

import ObjectMapper

//MARK:- GetBannerProductList
struct LoginDataModel: Mappable {
    var success : Bool?
    var message : String?
    var token : String?
    var userId : Int?
    //var errorCode : String?
    //var data : loginDataResponse?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        success <- map["status"]
        message <- map["message"]
        token <- map["token"]
        userId <- map["user_id"]
        //errorCode <- map["ErrorCode"]
        //data <- map["data"]
    }
}
struct loginDataResponse : Mappable {
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
