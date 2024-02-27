//
//  FavouriteViewController.swift
//  News App
//
//  Created by Сырлыбай Рамазан on 23.02.2024.
//

import UIKit
import SafariServices

class FavouriteViewController: NewsListViewController {
    
    override func configureUI(){
        super.configureUI()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem:
                .refresh, target: self, action: #selector(super.reloadNews))
    }


    public override func loadData(){
        self.articles = NewsListViewModel.shared.getFavoriteArticles()
        self.viewModels = self.articles.compactMap({
            NewsTableViewCellViewModel(
                article: $0,
                isSaved: true
            )
        })
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }

}
