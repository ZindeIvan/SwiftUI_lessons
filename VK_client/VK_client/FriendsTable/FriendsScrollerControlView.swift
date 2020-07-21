//
//  FriendsScrollerControlView.swift
//  VK_client
//
//  Created by Зинде Иван on 7/21/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

protocol FriendsScrollerControlViewDelegate : class {
    func scrollFriends(letter : Character)
}

class FriendsScrollerControlView : UIControl {
    
    //Элемент группировки
    private var stackView : UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var buttons: [UIButton] = []
    
    private var lettersArray : [Character] = []
    
//    var selectedLetter: Character? {
//        didSet {
//            sendActions(for: .valueChanged)
//        }
//    }
    
    weak var delegate : FriendsScrollerControlViewDelegate?
    
    func setLetters (letters : [Character]) {
        for letter in letters {
            lettersArray.append(letter)
        }
    }
    
    //Метод установки элементов
    func setupScrollerView() {
        
        for letter in lettersArray {
            let button = UIButton(type: .system)
            button.setTitle(String(letter).uppercased(), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.white, for: .selected)
            
            button.addTarget(self,
                             action: #selector(lettreSelected(_:)),
                             for: .touchUpInside)
            
            buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: buttons)
        
        stackView.spacing = 1
        stackView.axis = .vertical
        
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
    }
    //Обработчик нажатия буквы
    @objc func lettreSelected( _ button : UIButton){
        guard let index = buttons.firstIndex(of: button) else { return }
        let letter = lettersArray[index]
        delegate?.scrollFriends(letter : letter)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Установи границы группировочного элемента
        stackView.frame = bounds
    }
}
