//
//  ViewController.swift
//  weatherAPP
//
//  Created by Миржигит Суранбаев on 24/10/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController{
    
    
    let emailTF: UITextField = {
       let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Login"
        view.text = "alaimirjigit154@gmail.com"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.borderStyle = .roundedRect
        view.layer.cornerRadius = 10
        return view
    }()
    
    let passwordTF: UITextField = {
       let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Password"
        view.text = "mirjigit"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.borderStyle = .roundedRect
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var signIn: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Sign In", for: .normal)
        view.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var signUp: UIButton = {
       let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("SignUp", for: .normal)
        view.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var warningLbl: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .red
        view.textAlignment = .center
        view.text = "Warning"
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        warningLbl.alpha = 0
    }
    
    func displayWarningLabel(withText text: String) {
        warningLbl.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut], animations: { [weak self] in
            self?.warningLbl.alpha = 1
        }) { [weak self] complete in
            self?.warningLbl.alpha = 0
        }
    }
    
    @objc func tapSignIn(_ sender: UIButton){ // Войти
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is uncorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else {
                
                return }
            
            if error != nil {
                let alert = UIAlertController(title: "Ошибка", message: "Вы ввели не существующего пользователя.", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self?.present(alert, animated: true, completion: nil)
            }
            if user != nil {
                let vc = WeatherVC()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    @objc func tapSignUp(){ // Регистрация
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is uncorrect")
            return
        }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            guard let result = authResult else {
                // case when create unsuccessful
                let alert = UIAlertController(title: "Ошибка", message: "Вы ввели существующий логин или пароль", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                print("‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️‼️")
                return
            }
            
            // ...
            let alert = UIAlertController(title: "Успех", message: "Вы успешно зарегистрировались.", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
          }
        
    }
    
    
    func setupUI(){
        
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(signIn)
        view.addSubview(signUp)
        view.addSubview(warningLbl)
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailTF.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 30),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            
            signIn.topAnchor.constraint(equalTo: passwordTF.topAnchor, constant: 100),
            signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signIn.widthAnchor.constraint(equalToConstant: 200),
            
            signUp.topAnchor.constraint(equalTo: signIn.topAnchor, constant: 40),
            signUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUp.widthAnchor.constraint(equalToConstant: 200),
            
            warningLbl.topAnchor.constraint(equalTo: signUp.bottomAnchor, constant: 40),
            warningLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
