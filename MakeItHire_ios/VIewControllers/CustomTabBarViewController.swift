//
//  CustomTabBarViewController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/14/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let main = UINavigationController(rootViewController: ListingsTableViewController())
        main.tabBarItem.title = "Home"
        main.tabBarItem.image = #imageLiteral(resourceName: "ic_properties")
        
        
        
        let chat = UINavigationController(rootViewController: ChatterController())
        chat.tabBarItem.title = "Chat"
        chat.tabBarItem.image = #imageLiteral(resourceName: "ic_messages")
        
        
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem.title = "Profile"
        profile.tabBarItem.image = #imageLiteral(resourceName: "ic_profile")
        
       
        
        viewControllers = [main,chat,profile]
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
