//
//  DetailViewController.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var urlData: URLData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = urlData.shortURL?.absoluteString
    }
    
    static func instantiateViewController(_ storyboard: UIStoryboard?, _ urlData: URLData) -> DetailViewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        viewController.urlData = urlData
        return viewController
    }
    
}
