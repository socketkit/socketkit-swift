//
//  Security.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on 1/29/21.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import Foundation
import CommonCrypto


final class Security {
  
  static let shared = Security()
  
  func sign(_ input: Any, key: String) throws -> String {
    let data = try JSONSerialization.data(withJSONObject: input, options: .prettyPrinted)
    let digested = digest(input: data as NSData)
    return hexString(input: digested)
  }
}

extension Security {

  private func digest(input: NSData) -> NSData {
    let length = CC_SHA512_DIGEST_LENGTH
    var hash = [UInt8](repeating: 0, count: Int(length))
    CC_SHA512(input.bytes, UInt32(input.length), &hash)
    return NSData(bytes: hash, length: Int(length))
  }
  
  private func hexString(input: NSData) -> String {
    var bytes = [UInt8](repeating: 0, count: input.length)
    input.getBytes(&bytes, length: input.length)
    
    var hexString = ""
    for byte in bytes {
      hexString += String(format:"%02x", UInt8(byte))
    }
    
    return hexString
  }
}
