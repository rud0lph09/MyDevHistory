//
//  URLSessionExtention.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation

extension URLSession: ServiceSessionTypable {
  func getData(from url: URL,
                completion: @escaping (Data?, Error?) -> Void) {
    let task = dataTask(with: url) { (data, _, error) in
      completion(data, error)
    }

    task.resume()
  }
}
