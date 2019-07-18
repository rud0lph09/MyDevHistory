//
//  ViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ViewModel {


  /// This method request the image to the repository for a specific URL
  ///
  /// - Parameters:
  ///   - url: URL where the image should be at
  ///   - completion: what to do after image was or was not downloaded. If downloaded the completion will have in its arguments the desired image, if not it will contain a placeholder. If the placeholder could not load properly it will return nil.
  func getImage(fromURL url: URL?, completion: @escaping (UIImage?)->())  {
    ResumeRepository.downloadImageFrom(url: url) { (image) in
      completion(image ?? Images.placeholder)
    }
  }
}
