//
//  SkillsTableViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class SkillsTableViewController: ViewController {

  @IBOutlet weak var skillTableView: UITableView?

  var animator = CellAnimator()

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let viewModel = self.viewModel as? SkillsTableViewModel else { return }
    skillTableView?.delegate = self
    skillTableView?.dataSource = self
    viewModel.navigationController = self.navigationController
    viewModel.getNavBarItems(controller: self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
  }

}

// MARK: - UITableView Delegate & Datasource
extension SkillsTableViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let viewModel = self.viewModel as? SkillsTableViewModel else { return 0 }
    return viewModel.skills.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let emptyCell = UITableViewCell()
    guard let viewModel = self.viewModel as? SkillsTableViewModel else { return emptyCell }
    return viewModel.getCell(inTableView: tableView, forIndexPath: indexPath) ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return CellSize.normalCellSize
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    animator.animateAppearingCell(cell, addingUpDelay: true)
  }
}
