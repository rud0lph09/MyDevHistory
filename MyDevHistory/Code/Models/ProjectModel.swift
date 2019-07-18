//
//  ProyectModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct ProjectModel: Codable, PathToURLProtocol {

  var name: String?
  private var image: String?
  private var projectPath: String?
  var started: String?
  var ended: String?
  var description: String?
  var position: String?
  var skillsUsed: [SkillModel] = []

  /**
   Returns the Image URL
   */
  func getImageURL() -> URL? {
    return getURL(fromPath: image)
  }

  /**
   Returns the project URL where the project can be viewed
   */
  func getProjectURL() -> URL? {
    return getURL(fromPath: projectPath)
  }

  // MARK: - Path to URL Protocol
  internal func getURL(fromPath path: String?) -> URL? {
    guard let pathString = path else { return nil }
    return URL(string: pathString)
  }
 
}
