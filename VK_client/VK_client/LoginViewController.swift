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
    
    //Название перехода для входа
    let loginSegueName : String = "LoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Сэкономим время для тестирования
        //loginField.text = "admin"
        //passwordField.text = "12345"
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
   override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == loginSegueName else {return true }
        //Если проверка логина и пароля пройдена - осуществить переход
        if checkLoginInfo() {
            return true
        }
        //Если проверка не пройдена отобразить ошибку
        else {
            showLoginError()
            return false
        }

    }
}

