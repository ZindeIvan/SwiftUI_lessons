//
//  GroupsSearchTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/10/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

//Класс для отображения списка доступных групп пользователя
class GroupsSearchTableViewController : UITableViewController {
    
    @IBOutlet weak var groupsSearchBar : UISearchBar!
    
   //Свойство содержащее массив всех групп типа структура Group
   private var groupsList : [Group] = [
    
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
    
    private var groupsListSearchData : [Group] = []
    
    //Метод возвращает Группу по индексу
    func getGroupByIndex (index : Int) -> Group? {
        guard index >= 0 && index < groupsListSearchData.count else {return nil}
        return groupsListSearchData[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsSearchBar.delegate = self
        groupsListSearchData = groupsList
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Возвращаем количество ячеек таблицы = количеству элементов массива groupsList
        return groupsListSearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsSearchTableCell") as? GroupsSearchTableCell else { fatalError() }
        //Зададим надпись ячейки
        cell.groupSearchNameLabel.text = groupsListSearchData[indexPath.row].groupName
        //Установим иконку ячейки
        cell.groupSearchIconView.image = UIImage(named: groupsListSearchData[indexPath.row].groupID + "_icon")
        
        return cell
    }
}

extension GroupsSearchTableViewController : UISearchBarDelegate {
   
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        groupsSearchBar.text = ""
        groupsListSearchData = groupsList
        groupsSearchBar.endEditing(true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsListSearchData = searchText.isEmpty ? groupsList : groupsList.filter {
            (group: Group) -> Bool in
            return group.groupName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
}
