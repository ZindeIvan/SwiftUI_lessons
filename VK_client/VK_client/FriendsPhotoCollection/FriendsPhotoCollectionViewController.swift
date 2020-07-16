//
//  FriendsPhotoCollectionViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/9/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class FriendsPhotoCollectionViewController : UICollectionViewController {
    var friendID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendsPhotoCell", for: indexPath) as! FriendsPhotoCell
        let imagePath : String = friendID == nil ? "error" : friendID! + "_photo\(indexPath.row)"
        cell.friendPhotoImageView.image = UIImage(named: imagePath)
        return cell
    }
    
}
