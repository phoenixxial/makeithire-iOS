//
//  LoginViewController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/12/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import LBTAComponents
import Alamofire

class LoginViewController: UIViewController {

    
    
    let login = UITextField()
    let password = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    @objc func logmein() {
      
        
        APIManager.shared.logmein(login: login.text, pass: password.text) { (response) in
            
            if (response != nil) {
                if(response?.message == "Success") {
                    
                    guard let tok = response?.token else { return }
                    APIManager.token = "Bearer " + tok
                    print(APIManager.token)
                    APIManager.user = response?.user
                    
                    
                    self.present(CustomTabBarViewController(),animated: true,completion: nil)
                    
                }
                
            }
            
            else {
                print("Network error")
                
            }
            
        }
        
        
    }
    
    
    
    
    
    func setupUI() {
        
        view.backgroundColor = UIColor(displayP3Red: 26/255, green: 182/255, blue: 171/255, alpha: 0.9)
        
    
        
        let image = UIImageView(image: #imageLiteral(resourceName: "logo copy"))
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        
        [     image.widthAnchor.constraint(equalToConstant: 180),
              image.heightAnchor.constraint(equalToConstant: 100),
              image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
              image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ].forEach({$0.isActive = true})
        
        
        login.translatesAutoresizingMaskIntoConstraints = false
        login.autocorrectionType = .no
        login.placeholder = "Login"
        login.layer.cornerRadius = 3
        login.autocapitalizationType = .none
        login.backgroundColor = UIColor.white
        login.layer.borderWidth = 3
        login.textAlignment = .center
        login.backgroundColor = UIColor(displayP3Red: 251/255, green: 253/255, blue: 240/255, alpha: 1)
        
        view.addSubview(login)
        
        [login.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 1/2),
         login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         login.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
         login.heightAnchor.constraint(equalToConstant: 40)
            
            
            ].forEach({$0.isActive = true })
        
        
        
        password.translatesAutoresizingMaskIntoConstraints = false
        password.autocorrectionType = .no
        password.placeholder = "Password"
        password.layer.cornerRadius = 3
        password.autocapitalizationType = .none
        password.backgroundColor = .white
        password.layer.borderWidth = 3
        password.isSecureTextEntry = true
        view.addSubview(password)
        password.textAlignment = .center
        
        
        [password.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
         password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 10),
         password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         password.heightAnchor.constraint(equalToConstant: 40)
            
            ].forEach({$0.isActive = true})
        
        
        password.backgroundColor = UIColor(displayP3Red: 251/255, green: 253/255, blue: 240/255, alpha: 1)

        
        let loginButton = UIButton()
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = UIColor(displayP3Red: 122/255, green: 103/250, blue: 238/250, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        
        [
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
            
            
            
            
            ].forEach({$0.isActive = true
            })
        
        
        loginButton.addTarget(self, action: #selector(logmein), for: UIControlEvents.touchUpInside)
        
        
        let signupButton = UIButton()
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.backgroundColor = UIColor(displayP3Red: 122/255, green: 103/250, blue: 238/250, alpha: 1)
        signupButton.setTitle("Sign Up", for: .normal)
        
        
        view.addSubview(signupButton)
        
        [
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            signupButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
            
            ].forEach({$0.isActive = true})
        
        
        loginButton.backgroundColor = UIColor(displayP3Red: 29/255, green: 180/255, blue: 171/255, alpha: 1)
        signupButton.backgroundColor = UIColor(displayP3Red: 29/255, green: 180/255, blue: 171/255, alpha: 1)

        
        
    }
    
    
}
