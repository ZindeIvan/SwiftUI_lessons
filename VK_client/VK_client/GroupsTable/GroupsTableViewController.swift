//
//  GroupsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/10/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class GroupsTableViewController : UITableViewController {
    
    private var groupsList : [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableCell") as? GroupsTableCell else { fatalError() }
        cell.groupNameLabel.text = groupsList[indexPath.row].groupName
        cell.groupIconView.image = UIImage(named: groupsList[indexPath.row].groupID + "_icon")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGroup (segue: UIStoryboardSegue){
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? GroupsSearchTableViewController else {return}
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let group = allGroupsController.groupsList[indexPath.row]
                if !groupsList.contains(group) {
                    groupsList.append(group)
                    groupsList = groupsList.sorted()
                    tableView.reloadData()
                }
                
            }
        }
    }
}
