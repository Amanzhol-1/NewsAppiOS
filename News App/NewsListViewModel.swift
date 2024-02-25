//
//  NewsListViewModel.swift
//  News App
//
//  Created by Dias Jakupov on 24.02.2024.
//

import Foundation


class NewsListViewModel{
    static let shared: NewsListViewModel = NewsListViewModel()
    
    private let dbController: DBController
    private let apiCaller: APICaller
    
    private init(){
        dbController = DBController.shared
        apiCaller = APICaller.shared
    }
    
    public func getFavoriteArticles()->[Article]{
        return dbController.getAllArticles()
    }
    
    public func getArticlesOnline(onCompletion: @escaping ([Article: Bool]) -> Void){
        APICaller.shared.getTopStories(completion: { networkResult in
            let favorites = self.getFavoriteArticles()

            switch networkResult {
            case .success(let articles):
                var articlesToSavedState: [Article: Bool] = [:]
                for article in articles {
                    let isFavorite = favorites.contains { $0.url == article.url }
                    articlesToSavedState[article] = isFavorite
                }
                onCompletion(articlesToSavedState)

            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    public func searchArticles(query: String, onCompletion: @escaping ([Article: Bool]) -> Void) {
        APICaller.shared.search(with: query, completion: { networkResult in
            let favorites = self.getFavoriteArticles()

            switch networkResult {
            case .success(let articles):
                var articlesToSavedState: [Article: Bool] = [:]
                for article in articles {
                    let isFavorite = favorites.contains { $0.url == article.url }
                    articlesToSavedState[article] = isFavorite
                }
                onCompletion(articlesToSavedState)

            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

}
