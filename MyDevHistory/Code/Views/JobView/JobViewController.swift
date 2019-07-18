//
//  JobsViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class JobViewController: ViewController {

  @IBOutlet weak var jobDescriptionLogo: UIImageView?
  @IBOutlet weak var jobPositionLabel: UILabel?
  @IBOutlet weak var jobPeriodicity: UILabel?
  @IBOutlet weak var companyLabel: UILabel?
  @IBOutlet weak var projectsTableView: UITableView?

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let viewModel = self.viewModel as? JobViewModel else { return }
    projectsTableView?.delegate = self
    projectsTableView?.dataSource = self
    viewModel.navigationController = self.navigationController
    viewModel.getNavBarItems(controller: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    loadData()
  }

  func loadData() {
    guard let viewModel = self.viewModel as? JobViewModel else { return }
    viewModel.getCompanyLogo(forView: jobDescriptionLogo)
    jobPositionLabel?.text = viewModel.job?.position
    jobPeriodicity?.text = viewModel.getPeriodicity()
    companyLabel?.text = viewModel.job?.companyName
  }

}

//MARK: - TableView Protocols
extension JobViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = self.viewModel as? JobViewModel else { return 0 }
    return viewModel.job?.projects.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let emptyCell = UITableViewCell()
    guard let viewModel = self.viewModel as? JobViewModel else { return emptyCell }
    return viewModel.getCell(inTableView: tableView, forIndexPath: indexPath) ?? emptyCell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CellSize.normalCellSize
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let viewModel = self.viewModel as? JobViewModel, let controller = viewModel.getController(inTableView: tableView, forIndexPath: indexPath) as? ProjectViewController else { return }
    self.navigationController?.pushViewController(controller, animated: true)
  }
}
