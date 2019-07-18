//
//  JobModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct JobModel: Codable, PathToURLProtocol {

  var companyName: String?
  private var companyLogo: String?
  var position: String?
  var started: String?
  var ended: String?
  var isCurrentJob: Bool?
  var projects: [ProjectModel] = []

  /**
   Returns the Company Logo URL
   */
  func getCompanyLogoURL() -> URL? {
    return getURL(fromPath: companyLogo)
  }

  // MARK: - Path to URL Protocol
  internal func getURL(fromPath path: String?) -> URL? {
    guard let pathString = path else { return nil }
    return URL(string: pathString)
  }

}
