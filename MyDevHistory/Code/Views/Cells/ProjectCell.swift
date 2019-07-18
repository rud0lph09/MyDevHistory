//
//  ProjectCell.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ProjectCell: UITableViewCell, FillableCell {
  var viewModel: ProjectCellViewModel?
  @IBOutlet weak var projectIconView: UIImageView?
  @IBOutlet weak var projectNameLabel: UILabel?
  @IBOutlet weak var periodicityLabel: UILabel?
  @IBOutlet weak var positionLabel: UILabel?
  @IBOutlet weak var descriptionLabel: UILabel?
  func fill(withViewModel viewModel: ViewModel?) {
    guard let cellModel = viewModel as? ProjectCellViewModel else { return }
    self.viewModel = cellModel
    self.viewModel?.getProjectImage(forView: projectIconView)
    projectNameLabel?.text = self.viewModel?.project?.name
    periodicityLabel?.text = self.viewModel?.getPeriodicity()
    positionLabel?.text = self.viewModel?.project?.position
    descriptionLabel?.text = self.viewModel?.project?.description
  }
}
