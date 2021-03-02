//
//  DetailViewController.swift
//  OnlineNews
//
//  Created by Maria Kramer on 26.02.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
// Check that there's a url
        if articleUrl != nil  {
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
            }
            
            let request = URLRequest(url: url!)
            
// Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
            
// Load it in the webview
            webView.load(request)
        }
    }
    
    
}

extension DetailViewController : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
// Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
