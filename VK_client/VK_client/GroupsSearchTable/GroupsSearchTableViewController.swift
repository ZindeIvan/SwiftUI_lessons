//
//  GroupsSearchTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/10/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class GroupsSearchTableViewController : UITableViewController {
    
   var groupsList : [Group] = [
    
        Group(groupName: "A.R.G.U.S.", groupID: "argus"),
        Group(groupName: "Birds of Prey", groupID: "birdsofprey"),
        Group(groupName: "Daily Planet", groupID: "dailyplanet"),
        Group(groupName: "Doom Patrol", groupID: "doompatrol"),
        Group(groupName: "Green Lanterns Corps", groupID: "greenlanternscorps"),
        Group(groupName: "Justice League", groupID: "justiceleague"),
        Group(groupName: "Justice Society of America", groupID: "justicesocietyofamerica"),
        Group(groupName: "S.T.A.R. Labs", groupID: "starlabs"),
        Group(groupName: "Suicide Squad", groupID: "suicidesquad"),
        Group(groupName: "Teen Titans", groupID: "teentitans"),
        Group(groupName: "Wayne Enterprises", groupID: "wayneenterprises")
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsSearchTableCell") as? GroupsSearchTableCell else { fatalError() }
        cell.groupSearchNameLabel.text = groupsList[indexPath.row].groupName
        cell.groupSearchIconView.image = UIImage(named: groupsList[indexPath.row].groupID + "_icon")
        
        return cell
    }
}
