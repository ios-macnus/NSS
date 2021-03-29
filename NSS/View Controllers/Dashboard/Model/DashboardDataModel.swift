//
//  DashboardDataModel.swift
//  NSS
//
//  Created by Gowma on 19/02/21.
//

import ObjectMapper

struct DashboardDataModel: Mappable {
    var success : Bool?
    var message : String?
    //var errorCode : String?
    var data : dashboardProfileDataResponse?
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        success <- map["status"]
        message <- map["message"]
        //errorCode <- map["ErrorCode"]
        data <- map["data"]
    }
}

struct dashboardProfileDataResponse : Mappable {
    var profile : profileResponse?
   

    init?(map: Map) { }
    mutating func mapping(map: Map) {
        profile <- map["profile"]
       
    }
}

struct profileResponse : Mappable {
   
    var name : String?
    var country_name : String?
    var state_name : String?
    var city_name : String?
    var address : String?
    var email_address : String?
    var mobile_no : String?
    var about_me : String?
    var profile_photo_link : String?
    var registered_on : String?
    var skills : String?
    var total_earnings : Int?
    var amount_collected : Int?
    var amount_pending : Int?
    var application_submitted : Int?
    var review_count : Int?
    var rating_count : Int?
    
    init?(map: Map) { }
    mutating func mapping(map: Map) {
        name <- map["name"]
        country_name <- map["country_name"]
        state_name <- map["state_name"]
        city_name <- map["city_name"]
        address <- map["address"]
        email_address <- map["email_address"]
        mobile_no <- map["mobile_no"]
        about_me <- map["about_me"]
        profile_photo_link <- map["profile_photo_link"]
        registered_on <- map["registered_on"]
        skills <- map["skills"]
        total_earnings <- map["total_earnings"]
        amount_collected <- map["amount_collected"]
        amount_pending <- map["amount_pending"]
        application_submitted <- map["application_submitted"]
        review_count <- map["review_count"]
        rating_count <- map["rating_count"]
       
    }
}
