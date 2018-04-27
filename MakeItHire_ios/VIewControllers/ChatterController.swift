//
//  ChatterController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/26/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import UIKit



class ChatterController: UITableViewController {
    
    var chatters = [ChatWith]()

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    APIManager.shared.getStudentChats(completion: {(response )in

        if(response != nil) {
            
            guard let resp = response else { return }
            self.chatters = resp
            self.tableView.reloadData()
            
        }
        
    })
        
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
    self.navigationItem.title = "Chats"
    
    tableView.separatorColor = .black
    
    tableView.register(chatCell.self, forCellReuseIdentifier: "chatCell")
   // fetchData()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatCell
        cell.selectionStyle = .none
        // Configure the cell...
        
       // let size = CGSize(width: 250,  height:1000)
       // let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
      //  let estimatedFrame = NSString(string:  "CUSTOM").boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        cell.name.text = chatters[indexPath.row].RecruiterFirstName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let navi = ChatController()
        if let n = chatters[indexPath.row].RecruiterFirstName {
        navi.chatter = n
        }
        
        
        if let i = chatters[indexPath.row].idChat {
            navi.idChat = i
        }
        
       if let m = chatters[indexPath.row].StudentID {
            navi.myId = m
        }
        
     //   guard let id = APIManager.user.idUser else { return }
        
        self.navigationController?.pushViewController(navi, animated: true)
        
    }
    
    
}
















class chatCell: UITableViewCell {
    
    
    let heightForImg = 75
    
    let profImg: UIImageView = {
        let img = UIImageView()
        
        
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.black.cgColor
        img.clipsToBounds = true
        img.backgroundColor = .blue
        img.layer.cornerRadius = 75/2
        return img
        
    }()
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    var name: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.isSelectable = false
        return textView
        
        
    }()
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        
        setupCellUI()
        
    }
    
    
    func setupCellUI() {
        
        self.addSubview(profImg)
        self.addSubview(name)
        
        
        profImg.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 75)
        
        name.anchor(self.topAnchor, left: self.profImg.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

