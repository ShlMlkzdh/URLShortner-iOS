//
//  DetailViewController.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    var urlData: URLData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        webView.isHidden = true
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: (urlData.shortURL?.absoluteString)!)!))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        title = webView.title
        webView.isHidden = false
    }
    
    @IBAction func shareShortURL(_ sender: UIBarButtonItem) {
        let viewController = UIActivityViewController(activityItems: [urlData.shortURL!], applicationActivities: nil)
        present(viewController, animated: true, completion: nil)
    }
    
    static func instantiateViewController(_ storyboard: UIStoryboard?, _ urlData: URLData) -> DetailViewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        viewController.urlData = urlData
        return viewController
    }
    
}
