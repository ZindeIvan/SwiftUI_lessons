//
//  PhotoViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/31/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit

class PhotoViewController : UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    private var friendID : String?
    private var friendPhotoCount : Int?
    private var friendPhotoID : Int?
    
    func setPhotoInformation(friendID : String?, friendPhotoCount : Int, friendPhotoID : Int){
        self.friendID = friendID
        self.friendPhotoCount = friendPhotoCount
        self.friendPhotoID = friendPhotoID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Установим фото друга
        
        let imagePath : String = (friendID == nil || friendPhotoCount == nil || friendPhotoID == nil) ? "error" : friendID! + "_photo\(friendPhotoID!)"
        
        let image : UIImage = (UIImage(named: imagePath) == nil ? UIImage(named: "error") : UIImage(named: imagePath))!
        
        photoImageView.image = image
 
    }
    
}
