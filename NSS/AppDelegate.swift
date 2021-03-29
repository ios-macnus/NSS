//
//  AppDelegate.swift
//  NSS
//
//  Created by Gowma on 21/01/21.
//

import UIKit
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import Stripe
import IQKeyboardManager

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,
UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    var device_push_token =  ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // UITabBar.appearance().tintColor = UIColor.black
        IQKeyboardManager.shared().isEnabled = true

//        FirebaseApp.configure()
//               self.registerForFirebaseNotification(application: application)
//               Messaging.messaging().delegate = self
//        
////               ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
//               Messaging.messaging().isAutoInitEnabled = true
        
        StripeAPI.defaultPublishableKey = "pk_test_51HRX3mH4jIlUOh3H7Ku2XSX3Bj8HSiigdH32kXZ2ntmuPb6TKNpcS6fPh56QdXPcsFr359ZCAgCYvr8O0Ej030di004qvD9YDQ"
        
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.black
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            print("Not first launch.")
            UserDefaults.standard.set("", forKey: "Job_Id_Pass")
           
        }else {
            
            print("First launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            UserDefaults.standard.set("", forKey: "freelancer_user_id")
            UserDefaults.standard.set("", forKey: "freelancer_AccessToken")
            
            UserDefaults.standard.set("", forKey: "name")
            UserDefaults.standard.set("", forKey: "user_name")
            UserDefaults.standard.set("", forKey: "user_Type_Id")
            
            UserDefaults.standard.set("", forKey: "client_user_id")
            UserDefaults.standard.set("", forKey: "client_AccessToken")
            
            UserDefaults.standard.synchronize()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
     func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            let token = deviceToken.map{ data in String(format: "%02.2hhx", data) }.joined()
            Messaging.messaging().apnsToken = deviceToken//.description
        }
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
            self.device_push_token = "\(String(describing: fcmToken!))"
            UserDefaults.standard.set(self.device_push_token, forKey: "device_token_for_Login")

          print("Firebase registration token: \(String(describing: fcmToken))")
            
//            self.deviceRegister()

          let dataDict:[String: String] = ["token": fcmToken ?? ""]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
          // TODO: If necessary send token to application server.
          // Note: This callback is fired at each app startup and whenever a new token is generated.
        }
       
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
                print(notification.request.content.userInfo)
                completionHandler([ .alert,.badge, .sound])

        }
        func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
               // Print notification payload data
               print("Push notification received: \(data)")

               let aps = data[AnyHashable("title")]!

               print(aps)
           }
        func registerForFirebaseNotification(application: UIApplication) {
            if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self
                
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
            } else {
                let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
            }
            
            application.registerForRemoteNotifications()
        }
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
          // If you are receiving a notification message while your app is in the background,
          // this callback will not be fired till the user taps on the notification launching the application.
          // TODO: Handle data of notification

          // With swizzling disabled you must let Messaging know about the message, for Analytics
          // Messaging.messaging().appDidReceiveMessage(userInfo)

          // Print message ID.
    //      if let messageID = userInfo[gcmMessageIDKey] {
    //        print("Message ID: \(messageID)")
    //      }
            print("APN recieved")
            // print(userInfo)
            
            let state = application.applicationState
            switch state {
                
            case .inactive:
                print("Inactive")
    //            let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewVC")
    //                       vc1.selectedIndex = 4
    //                       let navigationController = UINavigationController(rootViewController: vc1)
    //                       navigationController.isNavigationBarHidden = true
    //                       self.window = UIWindow(frame: UIScreen.main.bounds)
    //                       self.window?.rootViewController = navigationController
    //                       self.window?.makeKeyAndVisible()
            case .background:
                print("Background")
                // update badge count here
                application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
                
            case .active:
                print("Active")

            }
          // Print full message.
          print(userInfo)

          completionHandler(UIBackgroundFetchResult.newData)
        }
        func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        }
        private func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UNNotificationRequest, completionHandler: @escaping () -> Void) {
            print(notification)
            print(identifier)
        }
        
        private func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UNNotificationRequest, withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
            print(notification)
                  print(responseInfo)
        }
        
        private func application(_ application: UIApplication, didReceive notification: UNNotificationRequest) {
             print(notification)
        }

        private func application(application: UIApplication, didReceiveLocalNotification userInfo: [NSObject : AnyObject]) {

            print("\(userInfo)")
        }

}

