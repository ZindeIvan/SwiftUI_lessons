//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/8/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class FriendsTableViewController : UITableViewController{
    
    private var FriendsList : [[String]] = [
        ["Bruce Wayne","batman_icon"],
        ["Clark Kent","superman_icon"],
        ["Diana Prince","wonderwoman_icon"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FriendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell") as? FriendsTableCell else { fatalError() }
        cell.friendNameLabel.text = FriendsList[indexPath.row][0]
        cell.friendIconView.image = UIImage(named: FriendsList[indexPath.row][1])
        return cell
    }
}

