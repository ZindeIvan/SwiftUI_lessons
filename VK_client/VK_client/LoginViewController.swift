//
//  ViewController.swift
//  VK_client
//
//  Created by Зинде Иван on 7/3/20.
//  Copyright © 2020 zindeivan. All rights reserved.
//

import UIKit
//Класс для отображения экрана входа
class LoginController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    //Элемент поля ввода пароля
    @IBOutlet weak var passwordField: UITextField!
    //Элемент поля ввода логина
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var loginAnimationView : UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var firstLoginCircle : UIView = UIView()
    var secondLoginCircle : UIView = UIView()
    var thirdLoginCircle : UIView = UIView()
    
    //Название перехода для входа
    let loginSegueName : String = "LoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Сэкономим время для тестирования
        loginField.text = "admin"
        passwordField.text = "12345"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func keyboardWillShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
    
    //Метод проверки пароля и логина
    private func checkLoginInfo() -> Bool {
        guard let loginText = loginField.text else { return false }
        guard let passwordText = passwordField.text else { return false }
        
        if loginText == "admin", passwordText == "12345" {
            return true
        }
        else {
            return false
        }
    }
    
    //Метод отображения ошибки ввода пароля и/или логина
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка!", message: "Логин и/или пароль не верны", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
   //Метод  проверки перехода на экран приложения
//   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        guard identifier == loginSegueName else {return true }
//        //Если проверка логина и пароля пройдена - осуществить переход
//        if checkLoginInfo() {
//
//        return true
//        }
//        //Если проверка не пройдена отобразить ошибку
//        else {
//            showLoginError()
//            return false
//        }
//
//    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        addLoginAnimationViews()
        
        self.loginButton.isHidden = true
        
        if checkLoginInfo() {
            performLoginAnimation(repeatCounter: 0, maxRepeatCount: 5)

        }
            //Если проверка не пройдена отобразить ошибку
        else {
            showLoginError()
        }
    }
    
    
}

extension LoginController {
    func addLoginAnimationViews(){
        
        let circleRadius : CGFloat = 10
        let dx = loginAnimationView.frame.width/3
        let circleBackgroundColor = UIColor.gray
        
        firstLoginCircle.frame = CGRect(x: dx - circleRadius*3, y: loginAnimationView.frame.height/2 - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        secondLoginCircle.frame = CGRect(x: dx * 2 - circleRadius*3, y: loginAnimationView.frame.height/2 - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        thirdLoginCircle.frame = CGRect(x: dx * 3 - circleRadius*3, y: loginAnimationView.frame.height/2 - circleRadius, width: circleRadius * 2, height: circleRadius * 2)
        
        firstLoginCircle.layer.cornerRadius = firstLoginCircle.frame.height / 2
        secondLoginCircle.layer.cornerRadius = secondLoginCircle.frame.height / 2
        thirdLoginCircle.layer.cornerRadius = thirdLoginCircle.frame.height / 2
        
        firstLoginCircle.backgroundColor = circleBackgroundColor
        secondLoginCircle.backgroundColor = circleBackgroundColor
        thirdLoginCircle.backgroundColor = circleBackgroundColor
        
        loginAnimationView.addSubview(firstLoginCircle)
        loginAnimationView.addSubview(secondLoginCircle)
        loginAnimationView.addSubview(thirdLoginCircle)
        
    }
}

extension LoginController {
   
    func performLoginAnimation(repeatCounter : Int, maxRepeatCount : Int){
        
        let duration : TimeInterval = 0.3
        UIView.animate(withDuration: duration,delay: 0,
                       animations: {
                        self.thirdLoginCircle.alpha = 1
                        self.firstLoginCircle.alpha = 0
                        
        }) {(result) in
            
            UIView.animate(withDuration: duration,delay: 0,
                           animations: {
                            self.secondLoginCircle.alpha = 0
                            self.firstLoginCircle.alpha = 1
                            
            }) {(result) in
                
                UIView.animate(withDuration: duration,delay: 0,
                               animations: {
                                self.thirdLoginCircle.alpha = 0
                                self.secondLoginCircle.alpha = 1
                                
                }) {(result) in
                    if repeatCounter == maxRepeatCount {
                        self.thirdLoginCircle.alpha = 1
                        self.performSegue(withIdentifier: self.loginSegueName, sender: self)
                    }
                    else {
                        let repeatCounter = repeatCounter + 1
                        self.performLoginAnimation(repeatCounter: repeatCounter, maxRepeatCount: maxRepeatCount)
                    }
                }
            }
        }
    }
}
