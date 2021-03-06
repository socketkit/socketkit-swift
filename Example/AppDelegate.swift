//
//  AppDelegate.swift
//  Example
//
//  Created by Yagiz Nizipli on Jan 29, 2021.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import UIKit
import Socketkit

// MARK: - AppDelegate

/// The AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  /// The UIWindow
  var window: UIWindow?
  
  /// The RootViewController
  var rootViewController: UIViewController {
    return ViewController()
  }
  
  /// Application did finish launching with options
  ///
  /// - Parameters:
  ///   - application: The UIApplication
  ///   - launchOptions: The LaunchOptions
  /// - Returns: The launch result
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Initialize UIWindow
    self.window = .init(frame: UIScreen.main.bounds)
    // Set RootViewController
    self.window?.rootViewController = self.rootViewController
    // Make Key and Visible
    self.window?.makeKeyAndVisible()
    // Return positive launch
    
    Socketkit.configure(with: application)
    Socketkit.track(.custom(name: "hello_from_socketkit"), properties: ["attribute": "value"])
    return true
  }
  
}
