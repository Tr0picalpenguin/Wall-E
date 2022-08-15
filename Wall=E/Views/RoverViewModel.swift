//
//  RoverViewModel.swift
//  Wall-E
//
//  Created by Scott Cox on 8/14/22.
//

import Foundation

protocol RoverViewModelelegate: AnyObject {
    func photosLoadedSuccessfully()
}

class RoverViewModel {
    
    var curiosityPhotos: [Photo] = []
    var opportunityPhotos: [Photo] = []
    var spiritPhotos: [Photo] = []
    
    private weak var delegate: RoverViewModelelegate?
    
    init(delegate: RoverViewModelelegate) {
        self.delegate = delegate
    }
    
    func fetchCuriosity(with searchDate: String) {
        guard let curiosityURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
        NetworkController.fetchTopLevel(with: curiosityURL) { [weak self] result in
            switch result {
            case . success(let topLevelDict):
                self?.curiosityPhotos = topLevelDict.photos
                self?.delegate?.photosLoadedSuccessfully()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func fetchOpportunity(with searchDate: String) {
        guard let opportunityURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
        NetworkController.fetchTopLevel(with: opportunityURL) { [weak self] result in
            switch result {
            case . success(let topLevelDict):
                self?.opportunityPhotos = topLevelDict.photos
                self?.delegate?.photosLoadedSuccessfully()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
    
    func fetchSpirit(with searchDate: String) {
        guard let spiritURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/spirit/photos?earth_date=\(searchDate)&api_key=\(NetworkController.apiKeyValue)") else { return }
        NetworkController.fetchTopLevel(with: spiritURL) { [weak self] result in
            switch result {
            case . success(let topLevelDict):
                self?.spiritPhotos = topLevelDict.photos
                self?.delegate?.photosLoadedSuccessfully()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}
