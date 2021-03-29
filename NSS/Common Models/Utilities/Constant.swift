//
//  Constant.swift
//  DeliverForMe
//
//  Created by Gowtham on 24/01/21.
//  Copyright © 2020 NSS. All rights reserved.
//

import Foundation
import UIKit

// MARK:- Storyboard name
public enum StoryBoard: String {
    case main = "Main"
    case tabbar = "TabBar"
    case dashboard = "Dashboard"
    case jobList = "JobList"
    case settings = "Settings"

}

// MARK:- Viewcontroller identifiers
public enum Identifiers: String {
    case loginSegVC = "LoginSegVC"
    case loginVC = "LoginVC"
    case forgotPassword = "ForgotPasswordVC"
    case registerMainVC = "RegisterMainVC"
    case tutorialVC = "TutorialVC"
    case resetPasswordVC = "ResetPasswordVC"
    case passwordSuccessVC = "PasswordSuccessVC"
    case registerFreeLauncherVC = "RegisterFreeLauncherVC"
    case skillsSelectionVC = "SkillsSelectionVC"
    case registerSuccessVC = "RegisterSuccessVC"
    
    //tabview
    case settingsTabVC = "SettingsTabVC"
    
    //Job List
    case jobListVC = "JobListVC"
    case jobDetailsMainVC = "JobDetailsMainVC"
    case jobDetailsVC = "JobDetailsVC"
    case clientProfileMainVC = "ClientProfileMainVC"
    
    //Activities
    case currentActivitiesVC = "ActivitiesListVC"
    case pastActivitiesVC = "PastActivitiesVC"
    case appliedActivitesVC = "AppliedActivitesVC"
    case favActivitiesVC = "FavActivitiesVC"
    
    //Settings
    case profileSettingsVC = "ProfileSettingsVC"
    case accountSettingsVC = "AccountSettingsVC"
   
}

// MARK:- Navigation style
public enum TransitionStyle {
    case push
    case present
    case child
}

enum popType {
    case back
    case root
    case to
}

// MARK:- Alert titles
public enum AlertTitle: String {
    case alertWarning = "Warning"
    case alertError = "Error"
    case alertSuccess = "Success"
    case unpredictedError = "Unpredicted error"
    case hint = "Hint"
    case apptitle = "DeliverForMe"
}

public enum AlertMessage: String {
    case emptyMobileNumber = "Please provide your mobile number"
    case emptyFirstName = "Please provide your first name"
    case emptyLastName = "Please provide your last name"
    case emptyEmail = "Please provide your email address"
    case validEmail = "Please provide the valid email address"
    case emptyMandatoryFields = "Please fill all mandatory fields"
    case addHelpers = "Please add your helper details"
    case unpredictedError = "Please contact your customer care"
    case savedSucessfully = "Your profile saved sucessfully"
    case tipsProfilePicture = "Add your profile picture to help the service provider identify you easily"
    case addRecord = "Record added successfully!"
    case deleteRecord = "Record deleted successfully!"
    case noLocation = "No location found"
}

var unpredictedError: String {
    return AlertMessage.unpredictedError.rawValue
}

struct Constant {
    
    static let Rec_job = "Recommended Jobs"
    static let Tren_job = "Trending Jobs"
    static let Near_job = "Jobs Near You"
    static let Lat_job = "Latest Jobs"

}
