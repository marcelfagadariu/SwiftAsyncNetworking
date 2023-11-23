# SwiftAsyncNetworking


[![Swift Version](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

SwiftAsyncNetworking is your go-to package for asynchronous network operations in Swift. With support for async/await, it facilitates smooth interactions with REST APIs, offering a concise and expressive syntax for making requests and decoding responses.

## Installation

### Swift Package Manager

You can use the Swift Package Manager to install your package by adding the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/marcelfagadariu/SwiftAsyncNetworking.git", from: "1.0.2"),
],
targets: [
    .target(
        name: "SwiftAsyncNetworking",
        dependencies: ["SwiftAsyncNetworking"]
    ),
]
```

## Usage

```swift
import SwiftAsyncNetworking

// You can create your custom session provider
class CustomSessionSession: SwiftAsyncNetworking {

    // MARK: - Init

    init() {
        super.init(session: CustomURLSession(), decoder: CustomDecoder())
    }
}

// And override the request to pass additional parameters
    override func request(url: URL, method: Method, headers: [String: String]) async throws -> URLRequest {
        var headers = headers
        headers["token"] = // your token
        return try await super.request(url: url, method: method, headers: headers)
    }
```
### OR

```swift
import SwiftAsyncNetworking

class YourService {
  func requestData() async throws -> [Data] {
        guard let url = URL(string: "\(APIUrl.dev.rawValue)/data") else {
            throw NetworkError.RequestError.invalidURL
        }

        let data: [Data] = try await SwiftAsyncNetworking().get(url: url, headers: [:])
        return data
    }
}
```

## Features

Feature 1: SwiftAsyncNetworking - is your go-to package for asynchronous network operations in Swift.

Feature 2: Logger - A simple logging utility for displaying messages at different log levels.

Feature 3: NetworkError - Enum representing errors that can occur during network operations.

## License
This package is released under the MIT License. See LICENSE for details.

## Contact

Email: marcel.fagadariu@yahoo.com
Twitter: @FagadariuMarcel
