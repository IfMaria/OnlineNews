//
//  ViewController.swift
//  OnlineNews
//
//  Created by Maria Kramer on 26.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        Set the viewcontroller as the datasource and delegate of the tableview
        tableView.delegate = self
        tableView.dataSource = self
        
//        Get the articles from the Article model
        model.delegate = self
        model.getArticles()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
// Detect which article the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
// The user hasn't selected anything
            return
        }
        
// Get the article the user tapped on
        let article = articles[indexPath!.row]
        
// Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
// Pass the article url to the detail view controller
        
        detailVC.articleUrl = article.url!
        
    }

}
extension ViewController: ArticleModelProtocol, UITableViewDataSource, UITableViewDelegate {
    
    func articlesRetrieved(_ articles: [Article]) {
// Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell

        let article = articles[indexPath.row]
        
        cell.displayArticle(article)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
    
    
}
