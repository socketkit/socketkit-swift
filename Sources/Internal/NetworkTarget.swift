//
//  NetworkTarget.swift
//  Socketkit
//
//  Created by Yagiz Nizipli on 3/23/21.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import Foundation
import UIKit


final class NetworkTarget {
  
  static let shared: NetworkTarget = .init()

  private let storage = Storage()
  private let url: URL? = {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "tracking.socketkit.com"
    components.path = "/v1/events"
    return components.url
  }()
  
  private let session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30
    configuration.timeoutIntervalForResource = 30
    return URLSession(configuration: configuration)
  }()
  
  func send(_ properties: [String: Any?], with options: Manager.Options) -> URLSessionDataTask? {
    guard let baseUrl = self.url else {
      print("[Socketkit] Failed to construct URL")
      return nil
    }
    
    var request = URLRequest(url: baseUrl)
    request.allowsCellularAccess = true
    if #available(iOSApplicationExtension 13.0, *) {
      request.allowsExpensiveNetworkAccess = true
      request.allowsConstrainedNetworkAccess = true
    }
    request.networkServiceType = .background
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    // Set Socketkit token as header
    request.setValue(options.token, forHTTPHeaderField: "x-socketkit-key")
    
    do {
      request.httpBody = try JSONSerialization.data(withJSONObject: properties, options: .prettyPrinted)
    } catch let error {
      print(error.localizedDescription)
      return nil
    }
    
    let task = session.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print("❌ [Socketkit] Unexpected Error: \(error.localizedDescription)")
        return
      }
      
      if let response = response as? HTTPURLResponse {
        if response.statusCode == 401 {
          print("❌ [Socketkit] Invalid Token: Unable to communicate with Socketkit servers")
        }
      }
    }

    task.resume()
    
    return task
  }
}
