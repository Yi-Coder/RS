//
//  AppDelegate.swift
//  RS
//
//  Created by liangyi on 8/16/16.
//  Copyright © 2016 liangyi. All rights reserved.
//

import UIKit
//import CoreData
//import CoreMotion
//import Alamofire
//import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var manager = CMMotionManager()
    //var locationmanager = CLLocationManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //manager.accelerometerUpdateInterval = 0.2
        /*manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) {
            (AccData: CMAccelerometerData?, error: NSError?) in
            //print("recording")
            Alamofire.request(.GET,"http://131.96.181.154:3000/test", parameters: ["data": "\(AccData?.acceleration.x)"])
        }*/
       
       // manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()) {
          //  (GyroData: CMGyroData?, error: NSError?) in
          //  Alamofire.request(.GET,"http://131.96.181.154:3000/test", parameters: ["data": "\(GyroData?.rotationRate.x)"])
        //}
        //locationmanager.allowsBackgroundLocationUpdates = true
        //locationmanager.requestAlwaysAuthorization()
        //locationmanager.startUpdatingLocation()
        
        
       // manager.gyroUpdateInterval = 0.2
       // print(manager.gyroAvailable)
        //manager.startGyroUpdates()
        //Alamofire.request(.GET,"http://131.96.181.154:3000/test", parameters: ["data": "\(manager.gyroData?.rotationRate.x)"])
        
       // while (manager.gyroAvailable) {
            //print(self.locationmanager.location?.altitude)
             //manager.startGyroUpdates()
            //print(manager.gyroData?.rotationRate.x)
           
            //Alamofire.request(.GET,"http://131.96.181.154:3000/test", parameters: ["data": "\(manager.gyroData?.rotationRate.x)"])
          //  manager.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()) {
         //(GyroData: CMGyroData?, error: NSError?) in
              //  print(GyroData?.rotationRate.x)
             //   Alamofire.request(.GET,"http://131.96.181.143:3000/test", parameters: ["data": "\(GyroData?.rotationRate.x)"])
             //   print("data")
            //}
    
        }
    

    func applicationWillEnterForeground(application: UIApplication) {
       // manager.stopGyroUpdates();
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       // self.saveContext()
    }

}



