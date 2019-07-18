//
//  SkillModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

enum SkillCategory: String {
  case programmingLenguage = "lang"
  case iOSDev = "iosDev"
  case markupLenguage = "mlang"
  case styleSheetLenguage = "slang"
  case framework = "framework"
  case archPattern = "arch"
  case designPattern = "pattern"
}

enum Proficiency: String {
  case begginner = "begginner"
  case adept = "adept"
  case intermediate = "intermediate"
  case proeficient = "proeficient"
  case expert = "expert"

}

struct SkillModel: Codable, PathToURLProtocol {
  var skillName: String?
  var category: String?
  var proficency: String?
  var isPrimary: Bool?
  private var icon: String?

  init(skillName: String, category: String, proficency: String, icon: String?) {
    self.skillName = skillName
    self.category = category
    self.proficency = proficency
    self.icon = icon
  }

  /**
   Returns the proficency as Proficiency
   */
  func getCategoryType() -> SkillCategory? {
    return SkillCategory.init(rawValue: category ?? "")
  }

  /**
   Returns the proficency as SkillCategory
   */
  func getProficiency() -> Proficiency? {
    return Proficiency.init(rawValue: self.proficency ?? "")
  }

  /**
   Returns the Icon Url
   */
  func getIconURL() -> URL? {
    return getURL(fromPath: icon)
  }

  // MARK: - Path to URL Protocol
  internal func getURL(fromPath path: String?) -> URL? {
    guard let pathString = path else { return nil }
    return URL(string: pathString)
  }
}
