//
//  UIofProfile.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/25/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import LBTAComponents
import UIKit

extension ProfileViewController {
    
    
    
    @objc func logMeOut() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func setupUI() {
        
        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-exit-50"), style: .done, target: self, action: #selector(logMeOut))
        
        
        view.backgroundColor = .white
        scrollView.addSubview(name)
        scrollView.addSubview(email)
        scrollView.addSubview(university)
        scrollView.addSubview(major)
        scrollView.addSubview(phone)
        scrollView.addSubview(links)
        scrollView.addSubview(projects)
        scrollView.addSubview(bio)
        view.addSubview(scrollView)
        
        
        let height = CGFloat(self.navigationController?.navigationBar.frame.height ?? 0)
        scrollView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: height, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        name.anchor(scrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        
        email.anchor(name.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        university.anchor(email.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        major.anchor(university.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        phone.anchor(major.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        links.anchor(phone.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 125)
        
        projects.anchor(links.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 125)
        
        bio.anchor(projects.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 125)
        
        fadinggIN()
        
    }
    
    
    func fadinggIN() {
    
    name.alpha = 0
    email.alpha = 0
    university.alpha = 0
    major.alpha = 0
    phone.alpha = 0
    links.alpha = 0
    projects.alpha = 0
    bio.alpha = 0
        
    let time = Double(0.6)
    
        [name, email,university,major,phone,links,projects,bio].forEach({self.temp = $0;UIView.transition(with: $0, duration: time + 0.4, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {self.temp.alpha = 100}, completion: nil)})
        
        
    }

    
}
