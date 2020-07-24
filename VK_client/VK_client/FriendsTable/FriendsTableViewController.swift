//
//  FriendsTableViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/8/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

//Класс для отображения списка друзей пользователя
class FriendsViewController : UIViewController{
    //Элемент таблицы
    @IBOutlet weak var friendsTableView: UITableView!
    //Элемент прокрутки
    @IBOutlet weak var friendsScroller : FriendsScrollerControlView!
    
    @IBOutlet weak var friendsSearchBar : UISearchBar!
    
    //Свойство содержащее массив друзей пользователя типа структура User
    private var friendsList : [User] = [
        User(userName: "Arthur Curry", userID: "aquaman"),
        User(userName: "Barbara Gordon", userID: "batgirl"),
        User(userName: "Barry Allen", userID: "flash"),
        User(userName: "Billy Batson", userID: "shazam"),
        User(userName: "Bruce Wayne", userID: "batman"),
        User(userName: "Clark Kent", userID: "superman"),
        User(userName: "Damian Wayne", userID: "robin"),
        User(userName: "Diana Prince", userID: "wonderwoman"),
        User(userName: "Dick Grayson", userID: "nightwing"),
        User(userName: "Dinah Lance", userID: "blackcanary"),
        User(userName: "John Constantine", userID: "hellblazer"),
        User(userName: "Hal Jordan", userID: "greenlantern"),
        User(userName: "Kendra Saunders", userID: "hawkgirl"),
        User(userName: "Oliver Queen", userID: "greenarrow"),
        User(userName: "Victor Stone", userID: "cyborg"),
        User(userName: "Zatanna Zatara", userID: "zatanna")
    ]
    
    private var friendsListSearchData : [User] = []
    
    //Словарь секций
    var sections : [Character: [String]] = [:]
    //Массив заголовков секций
    var sectionsTitles : [Character] = []
    
    //Текущий выбранный индекс таблицы
    var selectedIndexPath : IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        friendsSearchBar.delegate = self
        
        friendsListSearchData = friendsList
        
        //Настроим секции
        setupSections()
        //Настроим элемент прокрутки
        setupFriendsScroller()
        
        friendsTableView.register(UINib(nibName: "FriendsTableSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        friendsTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //Проверим идентификатор перехода
        if segue.identifier == "FriendsPhotoSegue" {
            //Если переход предназначен для открытия коллекции фото друга
            if let destination = segue.destination as? FriendsPhotoCollectionViewController {
                //Зададим идентификатор друга для коллекции которого вызван переход
                guard let username = sections[sectionsTitles[selectedIndexPath!.section]]?[selectedIndexPath!.row] else {
                    fatalError()
                }
                //Получим индекс массива друзей по имени пользователя
                let index = friendsListSearchData.firstIndex { (user) -> Bool in
                    if user.userName == username {
                        return true
                    }
                    return false
                }
                destination.friendID = friendsListSearchData[index!].userID
            }
        }
    }
    
    //Метод настройки секций
    func setupSections (){
        sections = [:]
        //Обойдем массив пользователей
        for user in friendsListSearchData {
            //Возьмем первую букву имени пользователя
            let firstLetter = user.userName.first!
            //Если в массиве секций уже есть секция с такой буквой
            //добавим в словарь имя пользователя
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(user.userName)
            }
            //В противном случае добавим новый элемент словаря
            else {
                sections[firstLetter] = [user.userName]
            }
        }
        //Заполним массив заголовков секций
        sectionsTitles = Array(sections.keys).sorted()
    }
    
    //Метод настройки элемента прокрутки
    func setupFriendsScroller (){
        //Вызовем метод заполнения массива букв элемента прокрутки
        friendsScroller.setLetters(letters: sectionsTitles)
        //Вызовем метод настройки элемента прокрутки
        friendsScroller.setupScrollerView()
        //Укажем текущий объект в качестве делегата
        friendsScroller.delegate = self
    }
    
}

extension FriendsViewController: UITableViewDataSource {    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Возвращаем количество элементов в секции
        return sections[sectionsTitles[section]]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //Возвращаем количество секций
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        //Возвращаем заголовки секций
//        return String(sectionsTitles[section])
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = friendsTableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as? FriendsTableSectionHeaderView else { fatalError() }
        header.label.text = String(sectionsTitles[section])
       
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableCell") as? FriendsTableCell else { fatalError() }
        guard let username = sections[sectionsTitles[indexPath.section]]?[indexPath.row] else {
            fatalError()
        }
        //Найдем индекс друга в списке друзей
        let index = friendsListSearchData.firstIndex { (user) -> Bool in
            if user.userName == username {
                return true
            }
            return false
        }
        
        //Зададим надпись ячейки
        cell.friendNameLabel.text = friendsListSearchData[index!].userName
        //Установим иконку ячейки
        cell.iconImageView.image = UIImage(named: friendsListSearchData[index!].userID + "_icon")
        //Установим настройки тени иконки аватарки друга
        cell.iconShadowView.configureLayer()
        //Установим настройки скругления иконки аватарки друга
        cell.iconImageView.configureLayer()
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        //Зададим переменную индекса выбранной ячейки
        selectedIndexPath = indexPath
        return indexPath
    }
    
}


extension FriendsViewController: UITableViewDelegate {
    
}

extension FriendsViewController : FriendsScrollerControlViewDelegate {
    //Метод прокрутки списка друзей
    func scrollFriends(letter: Character) {
        //Получим индекс секции по букве
        let index = sectionsTitles.firstIndex(of: letter)
        let indexPath = IndexPath(row: 0, section: index!)
        //Проматаем список до указанной позиции
        friendsTableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
}

extension FriendsViewController : UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       
        friendsSearchBar.text = ""
        friendsListSearchData = friendsList
        friendsSearchBar.endEditing(true)
        setupSections()
        friendsTableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        friendsListSearchData = searchText.isEmpty ? friendsList : friendsList.filter {
            (user: User) -> Bool in
                return user.userName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        setupSections()
        friendsTableView.reloadData()
    }
}
