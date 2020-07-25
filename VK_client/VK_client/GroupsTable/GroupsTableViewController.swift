//
//  GroupsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/10/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

//Класс для отображения списка групп пользователя
class GroupsTableViewController : UITableViewController {
    
    @IBOutlet weak var groupsSearchBar : UISearchBar!
    
    //Свойство содержащее массив групп пользователя типа структура Group
    private var groupsList : [Group] = []
    
    private var groupsListSearchData : [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsSearchBar.delegate = self
        groupsListSearchData = groupsList
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupsSearchBar.text = ""
        groupsListSearchData = groupsList
        groupsSearchBar.endEditing(true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Возвращаем количество ячеек таблицы = количеству элементов массива groupsList
        return groupsListSearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsTableCell") as? GroupsTableCell else { fatalError() }
        //Зададим надпись ячейки
        cell.groupNameLabel.text = groupsListSearchData[indexPath.row].groupName
        //Установим иконку ячейки
        cell.groupIconView.image = UIImage(named: groupsListSearchData[indexPath.row].groupID + "_icon")
        
        return cell
    }
    
    //Метод обработки стандартных действий с ячейкой таблицы
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Если действие - удаление
        if editingStyle == .delete {
            //Удалим группу из массива групп пользователя
            let group = groupsListSearchData[indexPath.row]
            groupsListSearchData.remove(at: indexPath.row)
            //Удалим ячейку из таблицы
            tableView.deleteRows(at: [indexPath], with: .fade)
            guard let index = groupsList.firstIndex(of: group) else {return}
            groupsList.remove(at: index)
        }
    }
    
    //Действие по добавлению группы
    @IBAction func addGroup (segue: UIStoryboardSegue){
       //Проверим идентификатор перехода
        if segue.identifier == "addGroup" {
            //Приведем источник перехода к классу всех доступных групп
            guard let allGroupsController = segue.source as? GroupsSearchTableViewController else {return}
            //Установим константу индекса выбранной строки
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                //Создадим константу выбранной группы по выбранному индексу
                let group = allGroupsController.getGroupByIndex(index: indexPath.row)!
                //Проверим нет ли в списке групп пользователя выбранной группы
                if !groupsList.contains(group) {
                    //Добавим группу в список
                    groupsList.append(group)
                    //Отсортируем список
                    groupsList = groupsList.sorted()
                    
                    groupsListSearchData = groupsList
                    //Обновим таблиц
                    tableView.reloadData()
                }
                
            }
        }
    }
}

extension GroupsTableViewController : UISearchBarDelegate {
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

