//
//  ViewMoreCell.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ViewMoreCell: UITableViewCell, FillableCell {
  @IBOutlet weak var titleLabel: UILabel?
  var viewModel: ViewMoreCellViewModel?
  func fill(withViewModel viewModel: ViewModel?) {
    guard let viewMoreCellViewModel = viewModel as? ViewMoreCellViewModel else { return }
    self.viewModel = viewMoreCellViewModel
    self.titleLabel?.text = self.viewModel?.title
  }
}
