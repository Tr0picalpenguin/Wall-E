//
//  RoverViewController.swift
//  Wall-E
//
//  Created by Scott Cox on 8/7/22.
//

import UIKit

class RoverViewController: UIViewController {
    
    
    let viewModel = RoverViewModel()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func segmentedControlTapped(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.titleForSegment(at: 0)
//           
        case 1:
            segmentedControl.titleForSegment(at: 1)
//
        case 2:
            segmentedControl.titleForSegment(at: 2)
//
        default:
            break
        }
        tableView.reloadData()
    }
    
    
}// End of class
extension RoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.curiostityPhotos.count
        case 1:
            return viewModel.opportunityPhotos.count
        default:
            return viewModel.spiritPhotos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as?
                RoverTableViewCell else { return UITableViewCell()}
        let photo: Photo
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            photo = viewModel.curiostityPhotos[indexPath.row]
        case 1:
            photo = viewModel.opportunityPhotos[indexPath.row]
        default:
            photo = viewModel.spiritPhotos[indexPath.row]
        }
        cell.updateViews(with: photo)
        return cell
    }
    
    
}

extension RoverViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        viewModel.fetchCuriosity(with: searchText)
        viewModel.fetchOpportunity(with: searchText)
        viewModel.fetchSpirit(with: searchText)
    }
}
extension RoverViewController: RoverViewModelDelegate {
    func photosLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
