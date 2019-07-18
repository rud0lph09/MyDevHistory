//
//  ProjectViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ProjectViewModel: ViewModel {

  var navigationController: UINavigationController?

  var project: ProjectModel?

  init(withProjectModel project: ProjectModel?) {
    self.project = project
  }

  func getPeriodicity() -> String {
    guard let endDateString = project?.ended else {
      return project?.started ?? ""
    }
    return project?.started ?? "" + " - " + endDateString
  }

  func getProjectImage(forView view: UIImageView?) {
    self.getImage(fromURL: self.project?.getImageURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  override internal func getImage(fromURL url: URL?, completion: @escaping (UIImage?) -> ()) {
    super.getImage(fromURL: url, completion: completion)
  }

}

//MARK: - TableViewModel Protocol
extension ProjectViewModel: TableViewViewModelProtocol {
  func getCell(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell? {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.skill) as? SkillCell else { return nil }
    let index = indexPath.row
    let cellModel = SkillCellViewModel(withSkillModel: project?.skillsUsed[index] ?? nil)
    cell.fill(withViewModel: cellModel)
    return cell
  }
}

//MARK: - Nabvigatable Protocol
extension ProjectViewModel: Navigatable {
  func getNavBarItems(controller: UIViewController) {
    guard let backImage = Images.backButton else { return }
    let backButton = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(self.popViewController))
    backButton.imageInsets = UIEdgeInsets(top: 0, left: -40, bottom: -4, right: 0)
    controller.navigationItem.setLeftBarButton(backButton, animated: false)
  }

  func popViewController() {
    navigationController?.popViewController(animated: true)
  }
}
