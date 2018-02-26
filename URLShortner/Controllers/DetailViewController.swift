//
//  DetailViewController.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    static func instantiateViewController(_ storyboard: UIStoryboard?) -> DetailViewController {
        return storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
    }
    
}
