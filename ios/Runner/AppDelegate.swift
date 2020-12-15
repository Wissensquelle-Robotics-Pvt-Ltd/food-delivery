import UIKit
import Flutter
import GoogleMaps
import Firebase
import Braintree

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyC2Xc4DZUFsgjYO5U-0opjUX_xxxxxxxxxxx")
    
    // AIzaSyBFE1JUa1pzL_c77dT1OBS_fRehDo7KnIE
    if #available(iOS 10.0, *) {
           UNUserNotificationCenter.current().delegate = self
       } else {
           // Fallback on earlier versions
       }
    
    
    //This is for Braintree
    BTAppSwitch.setReturnURLScheme("com.HDFoodZone.payments")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
    }
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if url.scheme?.localizedCaseInsensitiveCompare("com.HDFoodZone.payments") == .orderedSame {
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
    }
}
