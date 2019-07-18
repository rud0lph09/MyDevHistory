//
//  TestEnums.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

enum TestConfig {
  enum Error: Swift.Error {
    case missingKey, invalidValue
  }

  static func value<T>(forKey key: String) throws -> T where T: LosslessStringConvertible {
    let bundle = Bundle(for: RepoTests.self)
    guard let object = bundle.object(forInfoDictionaryKey: key) else {
      throw Error.missingKey
    }

    switch object {
    case let value as T:
      return value
    case let string as String:
      guard let value = T(string) else { fallthrough }
      return value
    default:
      throw Error.invalidValue
    }
  }
}

enum TestService {
  static var baseURL: String {
    let baseUrlString: String = try! TestConfig.value(forKey: "API_BASE_URL")
    return "https://" + "\(baseUrlString)"
  }

  static var endpoint: String {
    let endpointString: String = try! TestConfig.value(forKey: "PROFILE_ENDPOINT")
    return endpointString
  }
}
