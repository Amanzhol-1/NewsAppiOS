//
//  File.swift
//  News App
//
//  Created by Dias Jakupov on 23.02.2024.
//

import Foundation
import CoreData
import UIKit


public class DBController{
    let persistentContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    public static let shared: DBController = DBController()
    
    private init(){
        let appdel = UIApplication.shared.delegate as! AppDelegate
        persistentContainer = appdel.persistentContainer
        context = persistentContainer.viewContext
    }
    
    func saveContext(){
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveOrDeleteArticle(article: Article)->Bool{
        let fetchRequest = ArticleEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "url == %@", article.url ?? "")
        do{
            let existingEntry = try persistentContainer.viewContext.fetch(fetchRequest)
            if existingEntry.isEmpty {
                let entity = ArticleEntity(context: context)
                let sourceEntity = SourceEntity(context: context)
                sourceEntity.name = article.source.name
                entity.title = article.title
                entity.descr = article.description
                entity.source = sourceEntity
                entity.url = article.url
                entity.publishedAt = article.publishedAt
                entity.urlToImage = article.urlToImage
                saveContext()
                return true
            }
            else{
                for entry in existingEntry{
                    persistentContainer.viewContext.delete(entry)
                }
                saveContext()
                return false
            }
        }catch{
            print("Error during managing article")
            return false
        }
        
    }
    
    func getAllArticles()->[Article]{
        let fetchRequests = ArticleEntity.fetchRequest()
        do{
            let rawObjects = try context.fetch(fetchRequests)
            print(rawObjects.count)
            return rawObjects.map { entity in
                Article(source: Source(name:entity.source?.name ?? ""),
                        title: entity.title ?? "",
                        description: entity.descr,
                        url: entity.url,
                        urlToImage: entity.urlToImage,
                        publishedAt: entity.publishedAt ?? "")
            }
        }catch{
            print("Errors")
        }
        return []
    }
}
