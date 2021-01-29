//
//  Manager.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on 1/29/21.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import Foundation

final class Manager {
  
  static let shared = Manager()
  
  private var options: Options?
  private let storage = Storage()
  
  init() {}
  
  func configure() {
    do {
      options = try parseConfiguration()
      checkBootState()
    } catch {
      print("[Socketkit] Unexpected error: \(error).")
    }
  }
  
  func track(_ name: Socketkit.EventTypes, properties: [String: Any]) {
    guard let options = options else {
      return print("[Socketkit] Integration was accessed without configuring. Aborting.")
    }
    
    guard let signed = try? Security.shared.sign(properties, key: options.secret) else {
      return print("[Socketkit] Payload signing failed. Please try again later.")
    }
  }
}

extension Manager {
  
  struct Options: Decodable {
    
    var token: String
    var secret: String
  }
}

extension Manager {
  
  private func parseConfiguration() throws -> Options {
    let url = Bundle.main.url(forResource: "Socketkit", withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    return try! decoder.decode(Options.self, from: data)
  }
  
  private func checkBootState() {
    let properties = Properties.all
    
    // Track firstAppOpen event
    if storage.get("initial_boot") as? Bool != true {
      track(.firstAppOpen, properties: properties)
      storage.set("initial_boot", value: true)
    }
    
    // Track appUpdated event
    if let savedAppVersion = storage.get("app_version") as? String {
      let currentAppVersion = properties["$app_version"] as? String
      
      if savedAppVersion != currentAppVersion {
        storage.set("app_version", value: properties["$app_version"])
        track(.appUpdated, properties: properties)
      }
    } else {
      storage.set("app_version", value: properties["$app_version"])
    }
  }
}
