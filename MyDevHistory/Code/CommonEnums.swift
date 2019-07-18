//
//  CommonEnums.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

enum CellSize {
  static let normalCellSize: CGFloat = 76
}

enum CellReusableID {
  static let job = "JobCellID"
  static let project = "ProjectsCellID"
  static let skill = "SkillCellID"
  static let viewMore = "ViewMoreCellID"
  static let achievement = "AchivementCellID"
}

enum ViewControllerStoryboardsID {
  static let projectsView = "ProjectViewID"
  static let skillsView = "SkillsTableViewID"
  static let resumeView = "ResumeViewID"
  static let jobView = "JobViewID"
  static let achievementsView = "AchievementsViewID"
}

enum CommonStrings {
  static let profileLabel = "profile_label".localized
  static let myAchieventsLabel = "my_achievements_label".localized
  static let descriptionLabel = "descriptionl_label".localized
  static let viewMoreLabel = "view_more_label".localized
  static let loadingViewLabel = "wait_loading".localized
}

enum ResumeSectionTitles {
  static let jobs = "job_section_header".localized
  static let skills = "skills_header".localized
  static let otherProjects = "other_projects_header".localized
}

enum StoryboardNames {
  static let main = "Main"
  static let launchScreen = "LaunchScreen"
}

enum ApiEnvStrings {
  static var baseUrl: String {
    return "https://" + (Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? " ")
  }
  static var profileEndpoint: String {
    return Bundle.main.object(forInfoDictionaryKey: "PROFILE_ENDPOINT") as? String ?? " "
  }
  static var lastUpdated = "lastUpdated"
  static var shared = "shared"
}

enum ErrorMessages {
  static let unknownError = "unknown_error".localized
  static let emptyResponse = "empty_response".localized
  static let parsingError = "parsing_error".localized
  static let errorTitle = "error_title".localized
  static let errorReloadMesasge = "error_reload_message".localized
}

enum Images {
  static let backButton = UIImage(named: "backIcon")
  static let placeholder = UIImage(named: "placeholder")
}
