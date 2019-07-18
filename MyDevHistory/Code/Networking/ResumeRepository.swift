//
//  ResumeRepository.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ResumeRepository: PathToURLProtocol {

  var baseURL: String = ApiEnvStrings.baseUrl
  var endpoint: String = ApiEnvStrings.profileEndpoint
  var delegate: ResumeRepositoryDelegate?
  var session: ServiceSessionTypable?


  /// Initializer of ResumeRepository
  ///
  /// - Parameters:
  ///   - commonInit: Specifies if it should initizlized baseUrl and endpoint with current settings.
  ///   - session: This represents the session that will execute the http requests
  init(withSession session: ServiceSessionTypable?) {
    self.session = session
  }


  /// This method requests the Resume to remote service
  func getResume() {
    guard let url = getURL(fromPath: (baseURL) + (endpoint)) else { return }
    delegate?.repositoryWillStartRequest()
    session?.getData(from: url, completion: {(data, error) in
      guard error == nil else {
        let errorMessage = error?.localizedDescription ?? ErrorMessages.unknownError
        self.delegate?.repository(self, didFinishRequestWithErrorMessage: errorMessage)
        return
      }
      guard let responseData = data else {
        self.delegate?.repository(self, didFinishRequestWithErrorMessage: ErrorMessages.emptyResponse)
        return
      }

      do {
        guard let responseModel = try? JSONDecoder().decode(ResumeServiceResponseModel.self, from: responseData) else {
          self.delegate?.repository(self, didFinishRequestWithErrorMessage: ErrorMessages.parsingError)
          return
        }
        self.setLastUpdateString(responseModel.lastUpdated)
        self.delegate?.repository(self, didFinishRequestWithResume: responseModel)
      }
    })
  }

  /// Static method that downloads an image from a url
  ///
  /// - Parameters:
  ///   - url: URL where the image is located
  ///   - completion: what to do after image was download. It contains an optional if the image couldnt be downloaded it will be nil
  static func downloadImageFrom(url: URL?, completion: @escaping (UIImage?) -> ()) {
    guard let imageUrl = url else {
      completion(nil)
      return
    }
    let config = URLSessionConfiguration.default
    config.urlCache = ResumeCache.singleton
    let session = URLSession(configuration: config)
    session.dataTask(with: imageUrl) { (data, urlResponse, responseError) in
      guard let imageData = data, let image = UIImage(data: imageData),responseError == nil else  {
        completion(nil)
        return
      }
      completion(image)
      }.resume()
  }


  /// Returns a url
  ///
  /// - Parameter path: the path that you want to transform to a url
  /// - Returns: an optional for the url, if the string could be transformed to a url it will be nil
  func getURL(fromPath path: String?) -> URL? {
    guard let pathString = path else { return nil }
    return URL(string: pathString)
  }


  /// This method specifies if cache should be use. Based on last update.
  ///
  /// - Returns: Boolean representing if user should use cache
  func shouldUseCache() -> Bool {
    guard let lastUpdateString = UserDefaults.standard.string(forKey: ApiEnvStrings.lastUpdated) else { return false }
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM yyyy, hh:mm"
    let lastUpdate = formatter.date(from: lastUpdateString)
    let today = getTodaysDateWithCustomFormatter(withFormatter: formatter)
    guard let comparisonResult = lastUpdate?.compare(today) else { return false }
    return comparisonResult == .orderedAscending
  }

  private func getTodaysDateWithCustomFormatter(withFormatter formatter: DateFormatter) -> Date {    let today = Date()
    let todayString = formatter.string(from: today)
    return formatter.date(from: todayString) ?? today
  }


  /// This method sets the description
  ///
  /// - Parameter string: Sets last update string
  private func setLastUpdateString(_ string: String?) {
    guard let lastUpdateString = string else { return }
    UserDefaults.standard.set(lastUpdateString, forKey: ApiEnvStrings.lastUpdated)
    UserDefaults.standard.synchronize()
  }

}

class ResumeCache: URLCache {
  static var singleton = ResumeCache()
  private override init() {
    let cachePath = ApiEnvStrings.shared
    let memoryCapacity = 50 * 1024 * 1024
    super.init(memoryCapacity: memoryCapacity, diskCapacity: memoryCapacity, diskPath: cachePath)
  }
}

protocol ResumeRepositoryDelegate {

  /// This method is called then the repository finished a request but with an error
  ///
  /// - Parameters:
  ///   - repo: Repository that excecuted the request
  ///   - error: The error that was recieved in the requesrt
  func repository(_ repo: ResumeRepository, didFinishRequestWithErrorMessage error: String)
  func repository(_ repo: ResumeRepository, didFinishRequestWithResume resume: ResumeServiceResponseModel)
  func repositoryWillStartRequest()
}
