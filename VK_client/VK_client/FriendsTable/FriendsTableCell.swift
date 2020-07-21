//
//  FriendsTableCell.swift
//  VK_client
//
//  Created by Зинде Иван on 7/8/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

//Класс ячейки списка друзей пользователя
class FriendsTableCell : UITableViewCell {
    //Надпись имени друга
    @IBOutlet weak var friendNameLabel : UILabel!
    //Тень иконки аватарки друга
    @IBOutlet weak var iconShadowView : IconShadowView!
    //Округление иконки аватарки друга
    @IBOutlet weak var iconImageView : IconView!
}
