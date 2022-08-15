//
//  NetworkController.swift
//  Wall-E
//
//  Created by Scott Cox on 8/7/22.
//

import Foundation
import UIKit.UIImage
import UIKit

class NetworkController {
    
    static let baseUrlString = "https://api.nasa.gov/mars-photos/api/v1/rovers"
    
    // components
   
    private static let photos = "photos"
    
    // query items
    private static let apiKey = "api_key"
    static let apiKeyValue = "LPXPRphevVByIJB8SpsGh4aA5KuP10JOx1NJiVsu"
    private static let earthDate = "earth_date"
    private static let sol = "sol"
    private static let solValue = "1000"
    private static let camera = "camera"
    private static let cameraValue = "FHAZ"
    
    static func fetchTopLevel(with url: URL, completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.invalidURL))
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let photosDict = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(photosDict))
            } catch {
                print(error.localizedDescription)
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchPhoto(with rover: String, earthDate: String, completion: @escaping (Result<Photo, ResultError>) -> Void) {
        guard let baseURL = URL(string: baseUrlString) else {
            completion(.failure(.noData))
            return
        }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "rover/\(photos)"
        let solQueryItem = URLQueryItem(name: sol, value: solValue)
        let apiQuery = URLQueryItem(name: apiKey, value: apiKeyValue)
        urlComponents?.queryItems = [solQueryItem, apiQuery]
        guard let finalURL = urlComponents?.url else { return }
        print(finalURL)
    }
   
    static func fetchImage(with imageString: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        guard let imageURL = URL(string: imageString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: imageURL) { imageData, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
            guard let imageData = imageData else {
                completion(.failure(.noData))
                return
            }
            guard let image = UIImage(data: imageData) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(image))
        }.resume()
    }
} // end of class
