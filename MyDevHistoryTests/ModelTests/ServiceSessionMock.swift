//
//  ServiceSessionMock.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation
@testable import MyDevHistory

final class ServiceSessionMock: ServiceSessionTypable {

  /// Optional variable that represents the data recieved from a request.
  var data: Data?
  /// Optional variable that represents the error recieved from a request.
  var error: Error?

  func getData(from url: URL,
                completion: @escaping (Data?, Error?) -> Void) {
    completion(data, error)
  }
}
