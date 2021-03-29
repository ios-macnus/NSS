//
//  Constants.swift
//  Plano
//
//  Created by Gowthaman on 30/01/21.
//  Copyright © 2021 NSS. All rights reserved.
//

struct Constants {
    
    struct API {
  
        //static let URL = "https://staging.plano.co/planoapi/"
        static let URL = "https://www.plano.co/planoapi/"
        
        static let AUTHORIZATION = "Basic YjZjMDQxYzJkMmY5YmQ4ZTRlODM0YTFiMDc5MmE4NmEzOGE5NThmYToxNTAwODVlMjFmN2VjN2I4MTA5OWQ3ZDJiODA5MmRhNGExZWEyMTFlMzNkZjJiYzU1ODM2ZjVkMzc4ZWNlYjJmMjIzZjhmZjM3ZjUxNTRlMGMzOTg4NjcwMzUyYTJkMzU="
        static let X_USERNAME = "b6c041c2d2f9bd8e4e834a1b0792a86a38a958fa"
        static let X_PASSWORD = "150085e21f7ec7b81099d7d2b8092da4a1ea211e33df2bc55836f5d378eceb2f223f8ff37f5154e0c3988670352a2d35"
        
        static let DeviceType = "iOS"
        
        static let AppstoreUrl = "itms-apps://itunes.apple.com/app/id1261481045"
    }
    
    struct Products {
        static let LITE = "com.plano.planoapp.lite"
        static let FAMILY = "com.plano.planoapp.family"
        static let ANNUAL = "com.plano.planoapp.annual"
    }
    
    struct StoreConnect{
        static let SecretKey = "cdc1ef44b5fc41279934dcbcec954714"
    }
    
    struct iAP {
        static let production = "com.plano.planoapp"
        static let enterprise = "enterprise.codigo.planoent"
    }
    
    /**
     ************
     * Very important switch. Make sure to set `true` for production
     ************
     **/
    static let isProduction = true

    
    static let pointDeductionForTerminatingApp = 0
    
    static let maximumChildSessionPerDay = 4
    static let maximumEyeCalibrationPerDay = 10
    static var maximumGamePlayPerDay = 5
    
    static let childProgressScorePerDay = 10
    static let outsideSafeZoneBuffer = 50
    
    static let childSessionPeriodMinute = 35
    
    /// Production
    static let childSessionPeriod = 3*60 // seconds
    static let childSessionBeforeAfterGap = 1*60 // seconds
    static let childSessionBeforeAfterGapPlus1 = 60//6*60 // seconds
    static let breakTimePeriod = 90 // seconds
    static let breakTimeAfter5Minute = 60//5*60 // seconds
    static let deduct50PointsForContinueUsing = 60 // seconds
    static let gapTimeBetweenStopNowAndPanelty = 60 // seconds
    static let skipEyeCalibrationDeductionPointPeriod = 60 // seconds TODO: 60 seconds
    static let BreakQualifierN = 1*60 //seconds
    
    /// Debug
    static let childSessionPeriodDebug = 30 // seconds
    static let childSessionBeforeAfterGapDebug = 10 // seconds
    static let childSessionBeforeAfterGapPlus1Debug = 20 // seconds
    static let breakTimePeriodDebug = 15 // seconds // TODO: 90 second
    static let breakTimeAfter5MinuteDebug = 30 // seconds
    static let deduct50PointsForContinueUsingDebug = 10 // seconds
    static let gapTimeBetweenStopNowAndPaneltyDebug = 30 // seconds
    static let skipEyeCalibrationDeductionPointPeriodDebug = 30 // seconds TODO: 60 seconds

    static let usingDeviceAtNightHour = 19 // is after 7pm
    
    static let hideAdsAfterSecond = 3 // is after 7pm
    
    static let LanguageID = 4 //language ID
    
    static let verifyCheckMinute = 2 // which check subscription receipt every xxx minutes
    

}
