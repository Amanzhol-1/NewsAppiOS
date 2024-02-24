//
//  ViewController.swift
//  News App
//
//  Created by Молтабаров Аманжол on 22.02.2024.
//

import UIKit
import SafariServices

class ViewController: NewsListViewController, UISearchBarDelegate {
    
        
    private let searchVC = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                .refresh, target: self, action: #selector(reloadNews))
           navigationItem.leftBarButtonItem = refreshBarButtonItem
        
        loadData()
        createSearchBar()
        
        self.navigationItem.title = "News"
        
        
    }
    

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    override func loadData(){
        NewsListViewModel.shared.getArticlesOnline { data in
            self.articles = Array(data.keys)
            self.viewModels = self.articles.compactMap({
                NewsTableViewCellViewModel(
                    article: $0,
                    isSaved: data[$0] ?? false
                )
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    //Search
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        NewsListViewModel.shared.getArticlesOnline { data in
            self.articles = Array(data.keys)
            self.viewModels = self.articles.compactMap({
                NewsTableViewCellViewModel(

                    article: $0,
                    isSaved: data[$0] ?? false                )
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.searchVC.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc override func reloadNews() {
        loadData()
        searchVC.isActive = false
    }
    
    
}
