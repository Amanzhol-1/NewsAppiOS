//
//  APICaller.swift
//  News App
//
//  Created by Молтабаров Аманжол on 22.02.2024.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadLinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=0e6e74971bd4454f946cd2fde0d3e80b")
        static let techCrunchURL = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=0e6e74971bd4454f946cd2fde0d3e80b")
        static let byWSJInURL = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=0e6e74971bd4454f946cd2fde0d3e80b")
        static let searchUrlString = "https://newsapi.org/v2/everything?sortBy=popularity&apiKey=0e6e74971bd4454f946cd2fde0d3e80b&q="
            
        static var current = topHeadLinesURL
    }
    
    func updateNewsSource(to source: URL) {
        Constants.current = source
    }
    
    private init(){}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.current else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = Constants.searchUrlString + query
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

}

//Models

struct APIResponse: Codable {
    let articles: [Article]
}

struct Article: Codable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(url)
    }
    
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
