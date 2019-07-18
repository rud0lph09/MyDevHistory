//
//  AppDelegate.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    guard let navController = window?.rootViewController as? UINavigationController else { return false }
    let viewModel = ResumeViewModel()
    guard let resumeViewController = ResumeViewController.getController(withViewModel: viewModel, andStoryboardViewControllerID: ViewControllerStoryboardsID.resumeView), navController.topViewController == nil else { return false }
    navController.pushViewController(resumeViewController, animated: true)
    return true
  }
}

