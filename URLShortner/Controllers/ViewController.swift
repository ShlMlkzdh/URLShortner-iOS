//
//  ViewController.swift
//  URLShortner
//
//  Created by Soheil Malekzadeh on 2/25/18.
//  Copyright © 2018 Soheil Malekzadeh. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var urlDataList: [URLData] = []
    private var dataController: DataController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        if let urlDataList = getURLDataList(dataController.viewContext) {
            self.urlDataList = urlDataList
            tableView.reloadData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeNetworkRequest(textField.text)
        textField.resignFirstResponder()
        textField.text = nil
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "urlDatacell") else {
            fatalError("Cannot find 'urlDatacell'.")
        }
        let urlData = urlDataList[indexPath.row]
        cell.textLabel?.text = urlData.longURL?.absoluteString
        cell.detailTextLabel?.text = urlData.shortURL?.absoluteString
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let urlData = urlDataList[indexPath.row]
        let viewController = DetailViewController.instantiateViewController(storyboard, urlData)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let dataURL = urlDataList.remove(at: indexPath.row)
                dataController.viewContext.delete(dataURL)
                try self.dataController.viewContext.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                self.showErrorDialog("Oops! Something went wrong. Please try again later.")
            }
        }
    }

    private func getURLDataList(_ context: NSManagedObjectContext) -> [URLData]? {
        let fetchRequest: NSFetchRequest<URLData> = URLData.fetchRequest()
        let sortDescriptor =
            NSSortDescriptor(key: "timestamp", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return try? context.fetch(fetchRequest)
    }
    
    private func makeNetworkRequest(_ string: String?) {
        guard let string = string else {
            showErrorDialog("The long URL is empty!")
            return
        }
        GoogleAPIClient.sharedInstance.shortenURL(string) { (url, error) in
            if let error = error {
                self.showErrorDialog(error.localizedDescription)
            } else {
                let urlData = URLData(context: self.dataController.viewContext)
                urlData.longURL = URL(string: string)
                urlData.shortURL = url
                urlData.timestamp = Date()
                do {
                    try self.dataController.viewContext.save()
                } catch {
                    self.showErrorDialog("Oops! Something went wrong. Please try again later.")
                }
                self.urlDataList.insert(urlData, at: 0)
                DispatchQueue.main.async {
                    self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
                }
            }
        }
    }
    
    private func showErrorDialog(_ string: String) {
        let viewController = UIAlertController(title: "Error", message: string, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        viewController.addAction(action)
        present(viewController, animated: true, completion: nil)
    }
    
}
