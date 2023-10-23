//
//  AppDelegate.swift
//  testTask
//
//  Created by Edgar Sargsyan on 18.10.23.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var loadingView: UIView?
    var activityIndicator: UIActivityIndicatorView?

    let notificationCenter = UNUserNotificationCenter.current()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .alert]) { (granted,error)
            in
            guard granted else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                print(settings)
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
        window = UIWindow(frame: UIScreen.main.bounds)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "Page1")

        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        loadingView = UIView(frame: UIScreen.main.bounds)
        loadingView?.backgroundColor = UIColor(white: 0, alpha: 0.7)

        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        if let center = loadingView?.center {
            activityIndicator?.center = center
        }
        activityIndicator?.startAnimating()

        loadingView?.addSubview(activityIndicator!)

        if let loadingView = loadingView {
            window?.addSubview(loadingView)
        }

        DispatchQueue.global(qos: .userInitiated).async {
           
            Thread.sleep(forTimeInterval: 5.0)

            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating()
                self.loadingView?.removeFromSuperview()
                self.window?.rootViewController = rootViewController
            }
          }
        return true
    }
}

