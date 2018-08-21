//
//  ViewController.swift
//  JSONTutorial
//
//  Created by Juan Meza on 1/6/18.
//  Copyright © 2018 Tech-IN. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var tableData:[[String: AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = Bundle.main.url(forResource: "friends", withExtension: "json")
        
        if let url = url {
            
            let data = NSData(contentsOf: url)
            
            if let data = data {
                
                do {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                    
                    if let object = jsonObject as? [String: AnyObject] {
                        
                        if let allFriends = object["friends"] as? [[String: AnyObject]] {
                            
                            tableData = allFriends
                            tableView.reloadData()
                        }
                        
                        
                    }
                    
                } catch {
                    
                    print("error code")
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "jsonCell", for: indexPath)
        
        let friend = tableData[indexPath.row]
        let name = friend["fullName"] as? String
        let year = friend["dob"] as? String
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = year
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

