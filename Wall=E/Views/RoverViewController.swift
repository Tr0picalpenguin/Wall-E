//
//  RoverViewController.swift
//  Wall-E
//
//  Created by Scott Cox on 8/7/22.
//

import UIKit

class RoverViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var roverImageView: UIImageView!
    
    var viewModel: RoverViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        searchBar.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    

    @IBAction func roverIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            segmentedControl.titleForSegment(at: 0)
            viewModel.fetchCuriosity(with: searchBar.text!)
        case 1:
            segmentedControl.titleForSegment(at: 1)
            viewModel.fetchOpportunity(with: searchBar.text!)
        case 2:
            segmentedControl.titleForSegment(at: 2)
            viewModel.fetchSpirit(with: searchBar.text!)
        default:
            break
        }
    }
    
}

extension RoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return viewModel.curiosityPhotos.count
        case 1:
            return viewModel.opportunityPhotos.count
        default:
            return viewModel.spiritPhotos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? RoverTableViewCell else {return UITableViewCell()}
        let curiosityPhoto = viewModel.curiosityPhotos[indexPath.row]
        let oppoortunityPhoto = viewModel.opportunityPhotos[indexPath.row]
        let spiritPhoto = viewModel.spiritPhotos[indexPath.row]
        
        cell.updateViews(with: curiosityPhoto)
        
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
