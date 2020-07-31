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
    
    @IBOutlet weak var newPhotoImageView : UIImageView!
    private var newPhotoID : Int = 0
    
    private var friendID : String?
    private var friendPhotoCount : Int?
    private var friendPhotoID : Int?
    
    var interactiveAnimator: UIViewPropertyAnimator!
    
    func setPhotoInformation(friendID : String?, friendPhotoCount : Int, friendPhotoID : Int){
        self.friendID = friendID
        self.friendPhotoCount = friendPhotoCount
        self.friendPhotoID = friendPhotoID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagePath : String = (friendID == nil || friendPhotoCount == nil || friendPhotoID == nil) ? "error" : friendID! + "_photo\(friendPhotoID!)"
        
        let image : UIImage = (UIImage(named: imagePath) == nil ? UIImage(named: "error") : UIImage(named: imagePath))!

        photoImageView.image = image
        
        photoImageView.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        photoImageView.addGestureRecognizer(panGesture)
        newPhotoImageView.isHidden = true
 
    }
    
    @objc func onPan(_ recognizer :  UIPanGestureRecognizer){
        
        let velocity = recognizer.velocity(in:  self.view)
        
        let rightToLeftSwipe = velocity.x < 0

        switch recognizer.state {
            
        case .began:
            newPhotoID = friendPhotoID!

            if rightToLeftSwipe {
                newPhotoID += 1
            }
            else{
                newPhotoID -= 1
            }
            
            if newPhotoID == friendPhotoCount! {
                newPhotoID = 0
            }else if newPhotoID < 0 {
                newPhotoID = friendPhotoCount! - 1
            }

            if rightToLeftSwipe {
                newPhotoImageView.transform = CGAffineTransform(translationX: photoImageView.frame.width + 100, y: 0)

            }
            else{
                newPhotoImageView.transform = CGAffineTransform(translationX: -photoImageView.frame.width - 100, y: 0)

            }
            
            
            newPhotoImageView.image = UIImage(named: friendID! + "_photo\(newPhotoID)")
            
            interactiveAnimator?.startAnimation()

            interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                         curve: .easeIn,
                                                         animations: {
                                                            
                                                            self.newPhotoImageView.isHidden = false
                                                            if rightToLeftSwipe {
                                                                
                                                                self.photoImageView.transform = CGAffineTransform(translationX: -self.photoImageView.frame.width, y: 0)
                                                                self.newPhotoImageView.transform = CGAffineTransform(translationX: -self.newPhotoImageView.frame.width, y: 0)
                                                            }
                                                            else{
                                                                self.photoImageView.transform = CGAffineTransform(translationX: self.photoImageView.frame.width, y: 0)
                                                                self.newPhotoImageView.transform = CGAffineTransform(translationX: self.newPhotoImageView.frame.width, y: 0)
                                                            }
                                                            
            })
            interactiveAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self.view)
            interactiveAnimator.fractionComplete = abs(translation.x) / 800
        case .ended:
            interactiveAnimator.stopAnimation(true)
            
            photoImageView.image = UIImage(named: friendID! + "_photo\(newPhotoID)")
            friendPhotoID = newPhotoID
            photoImageView.transform = .identity
            newPhotoImageView.transform = .identity
            newPhotoImageView.isHidden = true
            
        default:
            return
        }
    }
    
}
