//
//  ResumeViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

enum ResumeTableViewControllerSections: Int {
  case jobs = 0, skills, otherProjects

  static let count: Int = {
    var currentCount: Int = 0
    while let _ = ResumeTableViewControllerSections(rawValue: currentCount) { currentCount += 1 }
    return currentCount
  }()
}

class ResumeViewController: ViewController {

  var animator = CellAnimator()

  @IBOutlet weak var tableView: UITableView?
  @IBOutlet weak var profilePictureView: UIImageView?
  @IBOutlet weak var profileNameLabel: UILabel?
  @IBOutlet weak var profilePositionLabel: UILabel?
  @IBOutlet weak var profileEmailButton: UIButton?
  @IBOutlet weak var profilePhoneButton: UIButton?
  @IBOutlet weak var extractLabel: UITextView?
  @IBOutlet weak var achievementsButton: UIButton?
  @IBOutlet weak var achievementsIcon: UILabel?
  @IBOutlet weak var loadingView: LoadingView?

  override func viewDidLoad() {
    guard let viewModel = self.viewModel as? ResumeViewModel else { return }
    viewModel.repository?.getResume()
    tableView?.delegate = self
    tableView?.dataSource = self
    setObservers()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    let cornerRadius = (self.profilePictureView?.frame.width ?? 0) / 2
    self.profilePictureView?.layer.cornerRadius = cornerRadius
    self.profilePictureView?.layer.borderColor = UIColor.darkGray.cgColor
    self.profilePictureView?.layer.borderWidth = 0.2
  }
 
  func setObservers() {
    var notificationName: String = ResumeViewModelNotificationName.requestDidStart
    NotificationCenter.default.addObserver(self, selector: #selector(showLoadingView), name: NSNotification.Name(rawValue: notificationName), object: nil)
    notificationName = ResumeViewModelNotificationName.requestDidFailed
    NotificationCenter.default.addObserver(self, selector: #selector(showErrorMessage), name: NSNotification.Name(rawValue: notificationName), object: nil)
    notificationName = ResumeViewModelNotificationName.requestDidSucceed
    NotificationCenter.default.addObserver(self, selector: #selector(shouldRefreshView), name: NSNotification.Name(rawValue: notificationName), object: nil)
  }

  @objc func shouldRefreshView() {
    guard let viewModel = self.viewModel as? ResumeViewModel, let resume = viewModel.resume else {
      showErrorMessage()
      return
    }
    hideLoadingView()
    let profileContainsAchievements = resume.achievements.count > 0
    DispatchQueue.main.async {
      self.profileEmailButton?.setTitle(resume.profile.phone, for: .normal)
      self.profilePhoneButton?.setTitle(resume.profile.email, for: .normal)
      self.extractLabel?.text = resume.profile.extract
      self.profileNameLabel?.text = resume.profile.fullName
      viewModel.getProfileImage(forView: self.profilePictureView)
      self.profilePositionLabel?.text = resume.profile.currentPosition
      self.tableView?.reloadData()
      self.achievementsIcon?.isHidden = !profileContainsAchievements
      self.achievementsButton?.isHidden = !profileContainsAchievements
    }
  }

  @objc func showErrorMessage() {
    guard let viewModel = self.viewModel as? ResumeViewModel else { return }
    hideLoadingView()
    let alert = UIAlertController(title: ErrorMessages.errorTitle, message: viewModel.getRecentErrorMessage() ?? ErrorMessages.unknownError, preferredStyle: .alert)
    let reloadAcction = UIAlertAction(title: ErrorMessages.errorReloadMesasge, style: .destructive) { (action) in
      viewModel.repository?.getResume()
    }
    alert.addAction(reloadAcction)
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }

  @objc func showLoadingView() {
    DispatchQueue.main.async {
      self.loadingView?.show()
    }
  }

  func hideLoadingView() {
    DispatchQueue.main.async {
      self.loadingView?.hide()

    }
  }

  @IBAction func showAchievementsAction() {
    guard let viewModel = self.viewModel as? ResumeViewModel else { return }
    guard let achievements = viewModel.resume?.achievements else { return }
    let achievementsViewModel = AchievementsViewModel(withAchievements: achievements)
    guard let controller = AchievementsViewController.getController(withViewModel: achievementsViewModel, viewControllerID: ViewControllerStoryboardsID.achievementsView) as? AchievementsViewController else { return }
    controller.modalTransitionStyle = .crossDissolve
    controller.modalPresentationStyle = .overCurrentContext
    self.present(controller, animated: true, completion: nil)
  }

  @IBAction func contactAction(sender: UIButton) {
    guard let senderTitle = sender.titleLabel?.text, let viewModel = self.viewModel as? ResumeViewModel,let profile = viewModel.resume?.profile, viewModel.stringIsEqualToPhoneOrEmail(senderTitle) else { return }
    let url = senderTitle == profile.phone ? viewModel.getPhoneURL() : viewModel.getEmailURL()
    guard let contactURL = url, UIApplication.shared.canOpenURL(contactURL) else { return }
    UIApplication.shared.open(contactURL, options: [:], completionHandler: nil)
  }

}

// MARK: - UITableView Delegate & Datasource
extension ResumeViewController: UITableViewDelegate, UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return ResumeTableViewControllerSections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let currentSection = ResumeTableViewControllerSections(rawValue: section), let viewModel = self.viewModel as? ResumeViewModel, let resume = viewModel.resume else { return 0 }
    switch currentSection {
    case .jobs:
      return resume.jobs.count
    case .skills:
      return ( viewModel.getPrimeSkills().count ) + 1
    case .otherProjects:
      return resume.otherProjects.count
    }
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let viewModel = self.viewModel as? ResumeViewModel else { return nil }
    return viewModel.getSectionTitleFor(index: section) ?? ""
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CellSize.normalCellSize
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let emptyCell = UITableViewCell()
    guard let viewModel = self.viewModel as? ResumeViewModel else { return emptyCell }
    return viewModel.getCell(inTableView: tableView, forIndexPath: indexPath) ?? emptyCell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let viewModel = self.viewModel as? ResumeViewModel, let controller =  viewModel.getController(inTableView: tableView, forIndexPath: indexPath) else { return }
    navigationController?.pushViewController(controller, animated: true)
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    animator.animateAppearingCell(cell, addingUpDelay: true)
  }

}

