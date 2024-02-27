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
 
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        title = "News"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        reloadNews()
        super.viewDidLoad()
        title = "Home"
        createSearchBar()
        createCategoryBar()
        let refreshBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                .refresh, target: self, action: #selector(reloadNews))
           navigationItem.leftBarButtonItem = refreshBarButtonItem
    
        loadData()
 self.navigationItem.title = "News"
 
        
        
    }
    
    private func createCategoryBar() {
        let segmentedControl = UISegmentedControl(items: ["Business USA", "WSJ", "TechCrunch"])
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    override func loadData(){
        super.loadData()
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        NewsListViewModel.shared.searchArticles(query: text) { data in
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
    
    @objc override func reloadNews() {
        loadData()
        searchVC.isActive = false
    }
    
    @objc func segmentedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            changeNewsSourceToBusinessUSA()
        case 1:
            changeNewsSourceToWSJ()
        case 2:
            changeNewsSourceToTechCrunch()
        default:
            break
        }
    }
    
    @objc func changeNewsSourceToTechCrunch() {
        APICaller.shared.updateNewsSource(to: APICaller.Constants.techCrunchURL!)
        reloadNews()
    }

    @objc func changeNewsSourceToWSJ() {
        APICaller.shared.updateNewsSource(to: APICaller.Constants.byWSJInURL!)
        reloadNews()
    }
    
    @objc func changeNewsSourceToBusinessUSA() {
        APICaller.shared.updateNewsSource(to: APICaller.Constants.topHeadLinesURL!)
        reloadNews()
    }
}
 
