//
//  SearchViewController.swift
//  SeatGeekCodingExercise
//
//  Created by Tiffany Sakaguchi on 7/16/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = SearchViewModel()
    let searchController = UISearchBar()
    var searchTerm = ""
       
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchController.delegate = self
        searchController.showsCancelButton = true
        navigationItem.titleView = searchController
        EventController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        tableView.reloadData()
    }
    
    private func loadData(searchTerm: String) {
        viewModel.searchForEvents(searchTerm: searchTerm, pagination: false) { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func clearData() {
        viewModel.clearEvents()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? DetailViewController else { return }
            
            let event = viewModel.getEvent(byIndex: indexPath.row)
            destinationVC.configOnSegue(viewModel: DetailViewModel(event: event))
        }
    }
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        let events = viewModel.getEvent(byIndex: indexPath.row)
        cell.event = events
        return cell
    }
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {
            return
        }
        self.searchTerm = searchBarText
        loadData(searchTerm: self.searchTerm)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchBarText = searchBar.text,
              searchBarText.count > 2 else {
            clearData()
            return
        }
        self.searchTerm = searchBarText
        loadData(searchTerm: self.searchTerm)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearData()
        searchController.text = ""
    }
    
}

extension SearchViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpinnerFooter()
            viewModel.searchForEvents(searchTerm: searchTerm, pagination: true) { success in
                DispatchQueue.main.async {
                    self.tableView.tableFooterView = nil
                }
                if success {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
}
