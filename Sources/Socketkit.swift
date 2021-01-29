//
//  Socketkit.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on Jan 29, 2021.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

// Include Foundation
@_exported import Foundation

public final class Socketkit {
  
  init() {}
  
  public static func configure() {
    Manager.shared.configure()
  }
  
  public static func track(_ name: EventTypes, properties: [String: Any]) {
    Manager.shared.track(name, properties: properties)
  }
}

extension Socketkit {
  
  public enum EventTypes {
    
    case firstAppOpen // unique
    case appUpdated // unique (app version)
    case appCrashed
    case appSession
    case inAppPurchase
    case custom(name: String)
  }
}
