//
//  Properties.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on 1/29/21.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
import WatchKit
#endif

public class Properties {
  
  static var all: [String: Any] = {
    var p: [String: Any] = [:]
    
    #if os(iOS) || os(tvOS)
    let screenSize = UIScreen.main.bounds.size
    p["screen_height"] = Int(screenSize.height)
    p["screen_width"] = Int(screenSize.width)
    p["os"] = UIDevice.current.systemName
    p["os_version"] = UIDevice.current.systemVersion
    
    #elseif os(macOS)
    if let screenSize = NSScreen.main?.frame.size {
      p["screen_height"] = Int(screenSize.height)
      p["screen_width"] = Int(screenSize.width)
    }
    p["os"] = "macOS"
    p["os_version"] = ProcessInfo.processInfo.operatingSystemVersionString
    
    #elseif os(watchOS)
    let watchDevice = WKInterfaceDevice.current()
    p["os"] = watchDevice.systemName
    p["os_version"] = watchDevice.systemVersion
    p["watch_model"] = Properties.watchModel()
    let screenSize = watchDevice.screenBounds.size
    p["screen_width"] = Int(screenSize.width)
    p["screen_height"] = Int(screenSize.height)
    #endif
    
    let infoDict = Bundle.main.infoDictionary
    if let infoDict = infoDict {
      p["app_build_number"] = infoDict["CFBundleVersion"]
      p["app_version_string"] = infoDict["CFBundleShortVersionString"]
    }
    p["manufacturer"] = "Apple"
    p["model"] = Properties.deviceModel()
    
    return p
  }()
  
  class func deviceModel() -> String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let size = MemoryLayout<CChar>.size
    let modelCode = withUnsafePointer(to: &systemInfo.machine) {
      $0.withMemoryRebound(to: CChar.self, capacity: size) {
        String(cString: UnsafePointer<CChar>($0))
      }
    }
    if let model = String(validatingUTF8: modelCode) {
      return model
    }
    return ""
  }
  
  #if os(watchOS)
  class func watchModel() -> String {
    let watchSize38mm = Int(136)
    let watchSize40mm = Int(162)
    let watchSize42mm = Int(156)
    let watchSize44mm = Int(184)
    
    let screenWidth = Int(WKInterfaceDevice.current().screenBounds.size.width)
    switch screenWidth {
    case watchSize38mm:
      return "Apple Watch 38mm"
    case watchSize40mm:
      return "Apple Watch 40mm"
    case watchSize42mm:
      return "Apple Watch 42mm"
    case watchSize44mm:
      return "Apple Watch 44mm"
    default:
      return "Apple Watch"
    }
  }
  #endif
}
