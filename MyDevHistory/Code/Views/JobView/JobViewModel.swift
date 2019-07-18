//
//  ProjectsViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class JobViewModel: ViewModel {

  var navigationController: UINavigationController?
  var job: JobModel?

  init(withJob job: JobModel?) {
    self.job = job
  }

  func getCompanyLogo(forView view: UIImageView?) {
    getImage(fromURL: job?.getCompanyLogoURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  func getPeriodicity() -> String {
    guard let endDateString = job?.ended else {
      return job?.started ?? ""
    }
    return job?.started ?? "" + " - " + endDateString
  }

}

//Nabvigatable Protocol
extension JobViewModel: Navigatable {
  func getNavBarItems(controller: UIViewController) {
    guard let backImage = Images.backButton else { return }

    let backButton = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: .plain, target: self, action: #selector(popViewController))
    backButton.imageInsets = UIEdgeInsets(top: 0, left: -40, bottom: -4, right: 0)
    controller.navigationItem.setLeftBarButton(backButton, animated: false)
  }

  func popViewController() {
    navigationController?.popViewController(animated: true)
  }
}

//MARK: - TableViewModel Protocol
extension JobViewModel: TableViewViewModelProtocol {
  func getCell(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell? {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReusableID.project) as? ProjectCell else { return nil }
    let index = indexPath.row
    let cellModel = ProjectCellViewModel(withProject: job?.projects[index])
    cell.fill(withViewModel: cellModel)
    return cell
  }

  func getController(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UIViewController? {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: true)
    let projectViewModel = ProjectViewModel(withProjectModel: job?.projects[indexPath.row])
    let controller = ProjectViewController.getController(withViewModel: projectViewModel, andStoryboardViewControllerID: ViewControllerStoryboardsID.projectsView)
    return controller
  }
}
