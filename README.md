<p align="center">
   <img height="100" src="https://cdn.socketkit.com/assets/icon-long.png" alt="Socketkit, Inc.">
</p>

<p align="center">
   <a href="https://developer.apple.com/swift/">
      <img src="https://img.shields.io/badge/Swift-5.2-orange.svg?style=flat" alt="Swift 5.2">
   </a>
   <a href="https://github.com/apple/swift-package-manager">
      <img src="https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg" alt="SPM">
   </a>
</p>

# Security focused analytics & subscription tracking

<p align="center">
Privacy and security focused mobile analytics & subscription management for iOS. Made by Socketkit, Inc. This package is under heavy development. API structure may change without any given notice. Use with caution. Not recommended for production environments.
</p>

## Features

- [x] Subscription tracking and management using StoreKit
- [x] Event tracking with built in support for iOS, tvOS and watchOS

## Example

The example application is the best way to see `socketkit` in action. Simply open the `socketkit.xcodeproj` and run the `Example` scheme.

## Installation

### Swift Package Manager

To integrate using Apple's [Swift Package Manager](https://swift.org/package-manager/), add the following as a dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/socketkit/socketkit-swift.git", from: "1.0.0")
]
```

Alternatively navigate to your Xcode project, select `Swift Packages` and click the `+` icon to search for `socketkit`.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate socketkit into your project manually. Simply drag the `Sources` Folder into your Xcode project.

### Usage

```swift
import Socketkit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    // Make sure that you've added your Socketkit.plist file as your resource.
    Socketkit.configure(with: application)
    
    // Track custom events using the following code
    Socketkit.track(.custom(name: "hello_from_socketkit"), properties: ["attribute": "value"])
    
    return true
  }
}
```

## Contributing
Contributions are very welcome 🙌

## License

```
socketkit
Copyright (c) 2021 Socketkit, Inc. hello@socketkit.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
