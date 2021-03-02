//
//  ArticleModel.swift
//  OnlineNews
//
//  Created by Maria Kramer on 26.02.2021.
//

import Foundation

protocol ArticleModelProtocol {
    
    func articlesRetrieved (_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    
    func getArticles(){
        
        //        Fire off the request to the API
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=b60f1caff35c4f4dbaf37f72078493f3"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //            Check that there are no errors and that there is data
            
            if error == nil && data != nil {
                
                let decoder = JSONDecoder()
               
                do {
                    
//                  Parse the json into ArticleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
//                    Get the articles
                    let articles = articleService.articles!

//                    Pass it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                } catch {
                  print("Error parsing the JSON")
                }
            }
        }
// Start the data task
        dataTask.resume()
    }
    
}
