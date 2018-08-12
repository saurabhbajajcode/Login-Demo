//
//  HomeViewController.swift
//  Login Demo
//
//  Created by Saurabh on 12/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var subscriptionIDLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var subscriptionAttributes: [String: Any]? {
        didSet {
            // reload tableview
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showCustomerName()
        showSubscriptionID()

        let included = AppManager.collection["included"] as! [[String: Any]]
        let types = included.compactMap( { $0["type"] } )  as? [String]
        if let subscriptionIndex = types?.index(of: "subscriptions") {
            // show subscription id
            if let subscriptionID = included[subscriptionIndex]["id"] as? String {
                subscriptionIDLabel.text = subscriptionID
            }

            // get attributes dict
            let subscriptionAttributes = included.compactMap ({ $0["attributes"] })[subscriptionIndex] as? [String: Any]
            // remove null values from subscription attributes dictionary
            let filteredAttributes = subscriptionAttributes?.filter { !($0.1 is NSNull) }

            self.subscriptionAttributes = filteredAttributes
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: helpers
    private func showCustomerName() {
        if let data = AppManager.collection["data"] as? [String: Any] {
            if let attributes = data["attributes"] as? [String: Any] {
                var nameString = ""
                if let firstname = attributes["first-name"] as? String {
                    nameString.append(firstname)
                }
                if let lastname = attributes["last-name"] as? String {
                    // add space between first name and last name
                    if nameString.isEmpty == false {
                        nameString.append(" ")
                    }
                    nameString.append(lastname)
                }
                self.title = nameString
            }
        }
    }

    private func showSubscriptionID() {

    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subscriptionAttributes?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionDetailCell")
        if let keys = subscriptionAttributes?.keys {
            let key = Array(keys)[indexPath.row]
            cell?.textLabel?.text = key
            let value = subscriptionAttributes![key]!
            if value is Bool {
                cell?.detailTextLabel?.text = value as? Bool == true ? "Yes" : "No"
            } else {
                cell?.detailTextLabel?.text = String(describing: subscriptionAttributes![key]!)
            }
        }
        return cell!
    }
}
