//
//  LikeControlView.swift
//  VK_client
//
//  Created by Зинде Иван on 7/12/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class LikeControlView : UIControl {
    var likeCount : Int = Int.random(in: 0 ..< 10) {
        didSet {
            likeCountLabel.text = String(likeCount)
        }
    }
    var likeIsSelected : Bool = false{
        didSet {
            updateLikes()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private var likeButton : UIButton!
    private var stackView : UIStackView!
    private var likeCountLabel : UILabel!
    
    private let selectedColor : UIColor = .red
    private let diselectedColor : UIColor = .black
    
    private func setupView() {
        
        self.backgroundColor = .clear
        
        likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.addTarget(self,
                             action:
                                #selector(likePressed(_:)),
                             for: .touchUpInside)
        likeButton.backgroundColor = .clear
        likeButton.tintColor = diselectedColor
        
        likeCountLabel = UILabel()
        likeCountLabel.text = String(likeCount)
        likeCountLabel.textColor = diselectedColor
        
        stackView = UIStackView()
        stackView.addArrangedSubview(likeCountLabel)
        stackView.addArrangedSubview(likeButton)
        
        stackView.spacing = 1
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        addSubview(stackView)
        
    }
    
    @objc func likePressed( _ button : UIButton){
        likeIsSelected = !likeIsSelected
    }
    
    private func updateLikes (){
        
        if likeIsSelected {
            likeCount += 1
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCountLabel.textColor = selectedColor
            likeButton.tintColor = selectedColor
        }
        else {
            likeCount -= 1
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCountLabel.textColor = diselectedColor
            likeButton.tintColor = diselectedColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
}
