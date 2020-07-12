//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/8/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

//Класс для отображения списка друзей пользователя
class FriendsTableViewController : UITableViewController{
    
    //Свойство содержащее массив друзей пользователя типа структура User
    private var friendsList : [User] = [
        User(userName: "Arthur Curry", userID: "aquaman"),
        User(userName: "Barry Allen", userID: "flash"),
        User(userName: "Bruce Wayne", userID: "batman"),
        User(userName: "Clark Kent", userID: "superman"),
        User(userName: "Diana Prince", userID: "wonderwoman"),
        User(userName: "Hal Jordan", userID: "greenlantern"),
        User(userName: "Victor Stone", userID: "cyborg")
    ]
    
    //Текущий выбранный индекс таблицы
    var selectedRowIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Возвращаем количество ячеек таблицы = количеству элементов массива friendsList
        return friendsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell") as? FriendsTableCell else { fatalError() }
        //Зададим надпись ячейки
        cell.friendNameLabel.text = friendsList[indexPath.row].userName
        //Установим иконку ячейки
        cell.friendIconView.image = UIImage(named: friendsList[indexPath.row].userID + "_icon")
        //Установим настройки тени иконки аватарки друга
        cell.iconShadowView.configureLayer()
        //Установим настройки скругления иконки аватарки друга
        cell.iconView.configureLayer()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //Зададим переменную индекса выбранной ячейки
        selectedRowIndex = indexPath.row
        return indexPath
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Проверим идентификатор перехода
        if segue.identifier == "FriendsPhotoSegue" {
            //Если переход предназначен для открытия коллекции фото друга
            if let destination = segue.destination as? FriendsPhotoCollectionViewController {
                //Зададим идентификатор друга для коллекции которого вызван переход
                destination.friendID = friendsList[selectedRowIndex].userID
            }
        }
    }
}

