//
//  ResumeViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

enum ResumeViewModelNotificationName {
  static var requestDidSucceed = "requestDidSucceed"
  static var requestDidFailed = "requestDidFail"
  static var requestDidStart = "requestDidStart"
}

enum ActionURL {
  static var call = "tel://"
  static var mailTo = "mailto://"
}

class ResumeViewModel: ViewModel, TableViewViewModelProtocol {
  var repository: ResumeRepository?
  var resume: ResumeServiceResponseModel?

  private var recentErrorMessage: String?

  override init() {
    super.init()
    let config = URLSessionConfiguration.default
    config.urlCache = repository?.shouldUseCache() ?? false ? ResumeCache.singleton : nil
    let session = URLSession(configuration: config)
    repository = ResumeRepository(withSession: session)
    repository?.delegate = self
  }

  func getSectionTitleFor(index: Int) -> String? {
    guard let section = ResumeTableViewControllerSections(rawValue: index) else { return nil }
    switch section {
    case .jobs:
      return ResumeSectionTitles.jobs
    case .otherProjects:
      return ResumeSectionTitles.otherProjects
    case .skills:
      return ResumeSectionTitles.skills
    }
  }

  func getProfileImage(forView view: UIImageView?) {
    getImage(fromURL: resume?.profile.getProfilePictureURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  func getPhoneURL() -> URL? {
    guard let phone = resume?.profile.phone else {
      return nil
    }
    return URL(string: ActionURL.call + phone)
  }

  func getEmailURL() -> URL? {
    guard let email = resume?.profile.email else {
      return nil
    }
    return URL(string: ActionURL.mailTo + email)
  }

  func stringIsEqualToPhoneOrEmail(_ string: String) -> Bool {
    guard let profile = self.resume?.profile else { return false }
    return string == profile.phone || string == profile.email
  }

  func getJobs() -> [JobModel] {
    guard let jobs = resume?.jobs else { return [] }
    return jobs
  }

  func getProjects() -> [ProjectModel] {
    guard let projects = resume?.otherProjects else { return [] }
    return projects
  }

  func getSkills() -> [SkillModel] {
    guard let skills = resume?.skills else { return [] }
    return skills
  }

  func getPrimeSkills() -> [SkillModel] {
    var primeSkillsArray: [SkillModel] = []
    guard let skills = resume?.skills else { return primeSkillsArray }
    for skill in skills where skill.isPrimary ?? false {
      primeSkillsArray.append(skill)
    }
    return primeSkillsArray
  }

  func getRecentErrorMessage() -> String? {
    return recentErrorMessage 
  }

  func notifyRequestDidSucceed() {
    let notificationName: String = ResumeViewModelNotificationName.requestDidSucceed
    let notification = Notification(name: Notification.Name(rawValue: notificationName), object: nil)
    NotificationCenter.default.post(notification as Notification)
  }

  func notifyRequestDidFailed() {
    let notificationName: String = ResumeViewModelNotificationName.requestDidFailed
    let notification = Notification(name: Notification.Name(rawValue: notificationName), object: nil)
    NotificationCenter.default.post(notification as Notification)
  }

  //MARK: - TableViewViewModel protocol

  func getController(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UIViewController? {
    guard let section = ResumeTableViewControllerSections(rawValue: indexPath.section) else { return nil }
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: true)
    switch section {
    case .jobs:
      let viewModel = JobViewModel(withJob: getJobs()[indexPath.row])
      return JobViewController.getController(withViewModel: viewModel, andStoryboardViewControllerID: ViewControllerStoryboardsID.jobView)
    case .skills where cell as? ViewMoreCell != nil:
      let viewModel = SkillsTableViewModel(withSkills: getSkills())
      return SkillsTableViewController.getController(withViewModel: viewModel, andStoryboardViewControllerID: ViewControllerStoryboardsID.skillsView)
    case .otherProjects:
      let viewModel = ProjectViewModel(withProjectModel: getProjects()[indexPath.row])
      return ProjectViewController.getController(withViewModel: viewModel, andStoryboardViewControllerID: ViewControllerStoryboardsID.projectsView)
    default:
      return nil
    }
  }

  func getCell(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell? {
    guard let section = ResumeTableViewControllerSections(rawValue: indexPath.section) else { return nil }
    var cellModel: ViewModel?
    let index = indexPath.row
    switch section {
    case .jobs:
      cellModel = JobCellViewModel(withJob: getJobs()[index])
      let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.job) as? JobCell
      cell?.fill(withViewModel: cellModel)
      return cell
    case .otherProjects:
      cellModel = ProjectCellViewModel(withProject: getProjects()[index])
      let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.project) as? ProjectCell
      cell?.fill(withViewModel: cellModel)
      return cell
    case .skills:
      if index == getPrimeSkills().count {
        cellModel = ViewMoreCellViewModel(withTitle: CommonStrings.viewMoreLabel)
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.viewMore) as? ViewMoreCell
        cell?.fill(withViewModel: cellModel)
        return cell
      }
      cellModel = SkillCellViewModel(withSkillModel: getPrimeSkills()[index])
      let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.skill) as? SkillCell
      cell?.fill(withViewModel: cellModel)
      return cell
    }
  }

  private func updateResume(_ resume: ResumeServiceResponseModel) {
    self.resume = resume
  }
}

extension ResumeViewModel: ResumeRepositoryDelegate {
  func repository(_ repo: ResumeRepository, didFinishRequestWithErrorMessage error: String) {
    self.notifyRequestDidFailed()
  }

  func repository(_ repo: ResumeRepository, didFinishRequestWithResume resume: ResumeServiceResponseModel) {
    updateResume(resume)
    self.notifyRequestDidSucceed()
  }

  func repositoryWillStartRequest() {

  }


}
