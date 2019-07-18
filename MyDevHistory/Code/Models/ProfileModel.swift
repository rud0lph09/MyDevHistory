//
//  ProfileModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct ProfileModel: Codable, PathToURLProtocol {
  var name: String?
  var extract: String?
  private var profilePhoto: String?
  var lastName: String?
  var secondLastName: String?
  var fullName: String?
  var age: Int?
  var currentPosition: String!
  var phone: String?
  var email: String?

  /**
   Returns the Profile picture Path
   */
  func getProfilePictureURL() -> URL? {
    return getURL(fromPath: profilePhoto)
  }

  // MARK: - Path to URL Protocol
  internal func getURL(fromPath path: String?) -> URL? {
    guard let pathString = path else { return nil }
    return URL(string: pathString)
  }
}
