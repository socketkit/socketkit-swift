//
//  Socketkit.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on Jan 29, 2021.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

// Include Foundation
@_exported import Foundation
@_exported import UIKit

public final class Socketkit {
  
  init() {}
  
  public static let version = "0.1.0"
  
  public static func configure(with application: UIApplication? = nil) {
    Manager.shared.configure()
  }
  
  public static func track(_ name: EventTypes, properties: [String: Any]) {
    Manager.shared.track(name, properties: properties)
  }
  
  public static func setOptOut(_ value: Bool) {
    Manager.shared.setClient(properties: ["is_opt_out": value])
  }
}

public extension Socketkit {
  
  enum EventTypes {
    
    case appOpen
    case appSession
    case inAppPurchase
    case setClient
    case custom(name: String)
    
    var name: String {
      switch self {
      case .appOpen: return "app_open"
      case .appSession: return "app_session"
      case .inAppPurchase: return "in_app_purchase"
      case .setClient: return "set_client"
      case .custom(let name): return name
      }
    }
    
    internal func construct(with properties: [String: Any?]) -> [String: Any?] {
      var state = properties
      state["name"] = name
      state["timestamp"] = NSDate().timeIntervalSince1970
      state["library_version"] = Socketkit.version
      return state
    }
  }
}
