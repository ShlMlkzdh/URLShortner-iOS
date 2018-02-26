//
//  GoogleAPIClient.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import Foundation
import UIKit

class GoogleAPIClient: APIClient {
    
    static let sharedInstance: GoogleAPIClient = GoogleAPIClient()
    
    private let baseURL = "https://www.googleapis.com"
    private let path = "/urlshortener/v1/url"
    private let apiKey = "AIzaSyBWExYcBQD6fLkka9Pov3_fF59sWg-6wZI"
    private var url: URL {
        return URL(string: "\(baseURL + path)?key=\(apiKey)")!
    }
    
    private init() {
    }
    
    func shortenURL(_ string: String, _ completion: @escaping Callback) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let json = ["longUrl": string]
        do {
            let data = Data(try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted))
            request.httpBody = data
        } catch {
            completion(nil, error)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
            } else {
                // Implement the parsing and getting the short URL here.
            }
        }
        dataTask.resume()
    }
    
}
