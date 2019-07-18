//
//  AchievmentsModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct AchievementsModel: Codable, PathToURLProtocol {
  var title: String?
  var date: String?
  var image: String?

  func getImageUrl() -> URL? {
    return getURL(fromPath: image)
  }

  func getURL(fromPath path: String?) -> URL? {
    guard let urlString = path else { return nil }
    return URL(string: urlString)
  }
}
