//
//  SkillsTableViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class SkillsTableViewModel: ViewModel {

  var skills: [SkillModel] = []
  var navigationController: UINavigationController?

  init(withSkills skills: [SkillModel]) {
    self.skills = skills
  }
}

//  MARK: - Navigatable Protocol

extension SkillsTableViewModel: Navigatable {

  func getNavBarItems(controller: UIViewController) {
    guard let backImage = Images.backButton else { return }
    let backButton = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popViewController))
    backButton.imageInsets = UIEdgeInsets(top: 0, left: -40, bottom: -4, right: 0)
    controller.navigationItem.setLeftBarButton(backButton, animated: false)
  }

  @objc func popViewController() {
    navigationController?.popViewController(animated: true)
  }

}

// MARK: - TableViewViewModel Protocol

extension SkillsTableViewModel: TableViewViewModelProtocol {
  func getCell(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell? {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.skill) as? SkillCell else { return nil }
    let index = indexPath.row
    let cellModel = SkillCellViewModel(withSkillModel: skills[index])
    cell.fill(withViewModel: cellModel)
    return cell
  }


}
