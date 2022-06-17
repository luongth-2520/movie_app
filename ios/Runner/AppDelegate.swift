import UIKit
import Flutter
import Firebase
import GoogleMaps
import flutter_config

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    //handle map key
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let setMapkeyChannel = FlutterMethodChannel(name: "com.asama.movieapp/map-key", binaryMessenger: controller.binaryMessenger)
      setMapkeyChannel.setMethodCallHandler { (call: FlutterMethodCall,result: @escaping FlutterResult) in
            if call.method == "setMapKey" {
                let args = call.arguments as? Dictionary<String, Any>
                let str = args?["mapKey"] as? String
                GMSServices.provideAPIKey(str!)
                result(true)
            }
        }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
