//
//  ProjectViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit
import SafariServices

class ProjectViewController: ViewController {

  var animator = CellAnimator()

  @IBOutlet weak var projectNameLabel: UILabel?
  @IBOutlet weak var projectImageView: UIImageView?
  @IBOutlet weak var positionLabel: UILabel?
  @IBOutlet weak var periodicityLabel: UILabel?
  @IBOutlet weak var viewMoreButton: UIButton?
  @IBOutlet weak var descriptionLabel: UILabel?
  @IBOutlet weak var skillSetTable: UITableView?

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let viewModel = self.viewModel as? ProjectViewModel else { return }
    skillSetTable?.delegate = self
    skillSetTable?.dataSource = self
    viewModel.navigationController = self.navigationController
    loadData()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    guard let viewModel = self.viewModel as? ProjectViewModel else { return }
    viewModel.getNavBarItems(controller: self)
  }


  /// This method updates the data contained in graphical objects
  func loadData() {
    guard let viewModel = self.viewModel as? ProjectViewModel else { return }
    self.projectNameLabel?.text = viewModel.project?.name
    viewModel.getProjectImage(forView: projectImageView)
    self.positionLabel?.text = viewModel.project?.position
    self.periodicityLabel?.text = viewModel.getPeriodicity()
    self.viewMoreButton?.isHidden = viewModel.project?.getProjectURL() != nil ? false : true
    self.descriptionLabel?.text = viewModel.project?.description
  }

  @IBAction func viewMoreAction() {
    guard let viewModel = self.viewModel as? ProjectViewModel, let projectUrl = viewModel.project?.getProjectURL() else { return }
    let controller = SFSafariViewController(url: projectUrl)
    self.present(controller, animated: true, completion: nil)
  }
}

// MARK: - UITableView Delegate & Datasource
extension ProjectViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = self.viewModel as? ProjectViewModel else { return 0 }
    return viewModel.project?.skillsUsed.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let emptyCell = UITableViewCell()
    guard let viewModel = self.viewModel as? ProjectViewModel else { return emptyCell }
    return viewModel.getCell(inTableView: tableView, forIndexPath: indexPath) ?? emptyCell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CellSize.normalCellSize
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    animator.animateAppearingCell(cell, addingUpDelay: true)
  }
}
