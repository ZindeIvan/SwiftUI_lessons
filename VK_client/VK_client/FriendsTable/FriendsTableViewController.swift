//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/8/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class FriendsTableViewController : UITableViewController{
    
    private var friendsList : [User] = [
        User(userName: "Arthur Curry", userID: "aquaman"),
        User(userName: "Barry Allen", userID: "flash"),
        User(userName: "Bruce Wayne", userID: "batman"),
        User(userName: "Clark Kent", userID: "superman"),
        User(userName: "Diana Prince", userID: "wonderwoman"),
        User(userName: "Hal Jordan", userID: "greenlantern"),
        User(userName: "Victor Stone", userID: "cyborg")
    ]
    
    var selectedRowIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell") as? FriendsTableCell else { fatalError() }
        cell.friendNameLabel.text = friendsList[indexPath.row].userName
        cell.friendIconView.image = UIImage(named: friendsList[indexPath.row].userID + "_icon")
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRowIndex = indexPath.row
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "FriendsPhotoSegue" {
            if let destination = segue.destination as? FriendsPhotoCollectionViewController {
                destination.friendID = friendsList[selectedRowIndex].userID
            }
        }
    }
}

