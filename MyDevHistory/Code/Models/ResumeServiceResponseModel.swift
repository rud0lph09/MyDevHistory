//
//  ResumeServiceResponseModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

struct ResumeServiceResponseModel: Codable {
  var lastUpdated: String?
  var profile: ProfileModel
  var jobs: [JobModel] = []
  var achievements: [AchievementsModel] = []
  var skills: [SkillModel] = []
  var otherProjects: [ProjectModel] = []
}
