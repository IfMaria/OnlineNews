//
//  ArticleCell.swift
//  OnlineNews
//
//  Created by Maria Kramer on 26.02.2021.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article){
        
        // Clean up the cell before displaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.headlineLabel.alpha = 1
        }, completion: nil)
        
        // Download and display the image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                self.articleImageView.alpha = 1
            }, completion: nil)
            
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create URL object")
            return
        }
        
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            if error == nil && data != nil {
                
                // Save the data into cache
                CacheManager.saveData(urlString, data!)
                
                if self.articleToDisplay?.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                    }
                }
            }
        }
        
        // Start the datatask
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
