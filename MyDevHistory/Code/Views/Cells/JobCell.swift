//
//  JobCell.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell, FillableCell {

  var viewModel: JobCellViewModel?
  @IBOutlet weak var iconView: UIImageView?
  @IBOutlet weak var jobNameLabel: UILabel?
  @IBOutlet weak var jobPositionLabel: UILabel?
  @IBOutlet weak var jobPeriodicityLabel: UILabel?

  func fill(withViewModel viewModel: ViewModel?) {
    guard let cellModel = viewModel as? JobCellViewModel else { return }
    self.viewModel = cellModel
    self.viewModel?.getCompanyLogo(forView: iconView)
    jobNameLabel?.text = self.viewModel?.job?.companyName
    jobPositionLabel?.text = self.viewModel?.job?.position
    jobPeriodicityLabel?.text = self.viewModel?.getPeriodicity()
  }


}
