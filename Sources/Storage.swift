//
//  Storage.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on 1/29/21.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import Foundation

final class Storage {
  
  private let defaults = UserDefaults.init(suiteName: "socketkit_client")
  
  func set(_ key: String, value: Any?) {
    defaults?.setValue(value, forKey: key)
  }
  
  func get(_ key: String) -> Any? {
    defaults?.value(forKey: key)
  }
  
  func remove(_ key: String) {
    defaults?.removeObject(forKey: key)
  }
  
  func removeAll() {
    defaults?.removeSuite(named: "socketkit_client")
  }
}
