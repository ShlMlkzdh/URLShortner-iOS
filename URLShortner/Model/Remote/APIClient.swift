//
//  APIClient.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import Foundation

public typealias Callback = (URL?, Error?) -> Void

protocol APIClient {
    
    func shortenURL(_ string: String, _ completion: @escaping Callback)
    
}
