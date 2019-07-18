//
//  ProjectCellViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ProjectCellViewModel: ViewModel {

  var project: ProjectModel?

  init(withProject project: ProjectModel?) {
    self.project = project
  }

  func getProjectImage(forView view: UIImageView?) {
    getImage(fromURL: project?.getImageURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  func getPeriodicity() -> String {
    guard let endDateString = project?.ended else {
      return project?.started ?? ""
    }
    return project?.started ?? "" + " - " + endDateString
  }
}
