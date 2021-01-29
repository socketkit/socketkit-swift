//
//  ViewController.swift
//  Example
//
//  Created by Yagiz Nizipli on Jan 29, 2021.
//  Copyright © 2021 Socketkit, Inc. All rights reserved.
//

import UIKit
import Socketkit

// MARK: - ViewController

/// The ViewController
class ViewController: UIViewController {
  
  // MARK: Properties
  
  /// The Label
  lazy var label: UILabel = {
    let label = UILabel()
    label.text = "🚀\nSocketkit\nExample"
    label.font = .systemFont(ofSize: 25, weight: .semibold)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    return label
  }()
  
  // MARK: View-Lifecycle
  
  /// View did load
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
  }
  
  /// LoadView
  override func loadView() {
    self.view = self.label
  }
  
}
