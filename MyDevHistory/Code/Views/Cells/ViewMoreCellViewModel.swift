//
//  ViewMoreCellViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/21/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

class ViewMoreCellViewModel: ViewModel {
  var title: String?

  init(withTitle title: String?) {
    self.title = title
  }
}
