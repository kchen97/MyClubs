//
//  ClubTableViewController.swift
//  MyClubs
//
//  Created by Korman Chen on 11/3/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit
import Firebase

class ClubTableViewController: UITableViewController {

    var currentUserClubs = [Club]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "customClubCell")
        
        loadUserClubs()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentUserClubs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customClubCell", for: indexPath) as! ClubTableViewCell
        
        let clubAtThisRow = currentUserClubs[indexPath.row]
        cell.clubNameLabel.text = clubAtThisRow.clubName
        cell.clubImage.image = clubAtThisRow.clubImage
        
        return cell
    }
    
    func loadUserClubs() {
        
    }
}
