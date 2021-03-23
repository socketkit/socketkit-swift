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
  
  private let network: NetworkTarget = .shared
  private var options: Options?
  private let storage = Storage()
  
  init() {}
  
  func configure() {
    do {
      options = try parseConfiguration()
      track(.appOpen, properties: Properties.all)
    } catch let error {
      print("❌ [Socketkit] Unexpected error: \(error.localizedDescription).")
    }
  }
  
  func track(_ event: Socketkit.EventTypes, properties: [String: Any?]) {
    guard let options = options else {
      return print("❌ [Socketkit] Integration was accessed without configuring. Aborting.")
    }
    
    if options.debugLogging == true {
      print("🚀 [Socketkit] Tracking \(event.name) with properties \(properties)")
    }
    
    let task = network.send(event.construct(with: properties), with: options)
  }
  
  func setClient(properties: [String: Any?]) {
    track(.setClient, properties: properties)
  }
}

extension Manager {
  
  struct Options: Decodable {
    
    var token: String
    var secret: String? = nil
    var debugLogging: Bool? = false
  }
}

extension Manager {
  
  private func parseConfiguration() throws -> Options? {
    guard let url = Bundle.main.url(forResource: "Socketkit", withExtension: "plist") else {
      print("❌ [Socketkit] Missing Socketkit.plist file")
      return nil
    }
    let data = try! Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    return try! decoder.decode(Options.self, from: data)
  }
}
