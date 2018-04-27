//
//  ChatController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/26/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ChatController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var bottomConstraint: NSLayoutConstraint?

    
    var Timera: Timer!

    
    var chatter = String()
    var idChat = Int()
    var myId = Int()
    
    
    var messages = [Message]()
    
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    let inputTextField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = UIColor.white
        
        return textField
    }()
    
    
    let bottom: UIView = {
        let v = UIView()
        
        v.backgroundColor = UIColor(displayP3Red: 13/255, green: 12/255, blue: 18/255, alpha: 1)
        
        return v
        
    }()
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messages[indexPath.row].Message
        
        
        let size = CGSize(width:250, height:1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: message!).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        return estimatedFrame.height+30
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! message
        
        
        cell.selectionStyle = .none
        
        let size = CGSize(width: 250,  height:1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: messages[indexPath.row].Message!).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        
        
        if (messages[indexPath.row].idUser == myId ) {
            cell.messageTextView.frame = CGRect(x:view.frame.maxX-48-8-20-estimatedFrame.width
                , y:0, width:estimatedFrame.width + 16, height:estimatedFrame.height + 15)
            cell.boolFlag = true
            
            
            cell.messageTextView.text = messages[indexPath.row].Message
          
        }
        else {
            
            cell.messageTextView.text = messages[indexPath.row].Message
            cell.messageTextView.frame = CGRect(x:48 + 8, y:0, width:estimatedFrame.width + 16, height:estimatedFrame.height + 15)
            cell.changeReceiver()
        }
 
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = chatter

        self.tabBarController?.tabBar.isHidden = true
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.register(message.self, forCellReuseIdentifier: "message")
        
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tableView.isUserInteractionEnabled = true
        tableView.addGestureRecognizer(gest)
        
        setupUI()
        
        
      //  self.navigationItem.title = conversator.mail
        self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
      //  fetchMessages()
      
        fetchMessages()
        
        Timera = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchMessages), userInfo: nil, repeats: true)

    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)

    }
    
    
    @objc func fetchMessages() {
        
        APIManager.shared.getMessages(idChat: idChat, completion: {(response) in
            if(response?.count != self.messages.count) {
                
                guard let resp = response else { return }
                self.messages = resp
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                      let indexPath = IndexPath(item: self.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    
                    
                }
            }
            
        })
    }
    func setupUI() {
        view.addSubview(tableView)
        view.addSubview(bottom)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottom.translatesAutoresizingMaskIntoConstraints = false
        //    tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = NSLayoutConstraint(item: bottom, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
        
        [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            // table.heightAnchor.constraint(equalTo: view.heightAnchor,constant:-75),
            tableView.bottomAnchor.constraint(equalTo: self.bottom.topAnchor, constant: 0),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            ].forEach({$0.isActive = true})
        
        bottom.heightAnchor.constraint(equalToConstant: 75).isActive = true
        bottom.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottom.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        
        
        bottom.addSubview(sendButton)
        bottom.addSubview(inputTextField)
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            
            inputTextField.topAnchor.constraint(equalTo: bottom.topAnchor),
            inputTextField.heightAnchor.constraint(equalTo: bottom.heightAnchor),
            inputTextField.leftAnchor.constraint(equalTo: view.leftAnchor),
            inputTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-75)
            ].forEach({$0.isActive = true})
        
        
        [
            
            sendButton.topAnchor.constraint(equalTo: bottom.topAnchor),
            sendButton.heightAnchor.constraint(equalTo: bottom.heightAnchor),
            sendButton.leftAnchor.constraint(equalTo: inputTextField.rightAnchor),
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor)
            ].forEach({$0.isActive = true})
        sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)
        
        
    }
    
    @objc func sendMessage() {
        
        
        if(inputTextField.text != "" && (inputTextField.text?.count)! < 255) {
            
            APIManager.shared.replyTo(idChat: self.idChat, message: inputTextField.text!, completion: {(response) in
                
                if(response == "Success") {
                
                }
                
            })
        }
        
        inputTextField.text = ""
        
        
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        var keyboardHeight = CGFloat(0)
        if notification.userInfo != nil {
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
                
            }
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            if isKeyboardShowing {
                bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
                if self.messages.count != 0 {
                    let indexPath = IndexPath(item: self.messages.count-1, section: 0)
                    
                    
                   self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
                
            else {
                
                bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
                
            }
            
            
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                
                
            })
            
        }
        
        
    }

}


class message: UITableViewCell {
    
    
    
    var tempAncor: NSLayoutConstraint?
    
    var boolFlag: Bool! {
        didSet {
            
            greyBubble.removeFromSuperview()
            avatarImgUrl.removeFromSuperview()
            self.addSubview(myAvatar)
            self.addSubview(blueBubble)
            
            myAvatar.anchor(nil, left: nil, bottom: self.messageTextView.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 30, heightConstant: 30)
            
            
            [ blueBubble.leftAnchor.constraint(equalTo: self.messageTextView.leftAnchor, constant:-5),
              blueBubble.rightAnchor.constraint(equalTo: self.myAvatar.leftAnchor, constant: -5),
              blueBubble.topAnchor.constraint(equalTo: self.topAnchor),
              blueBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})
            
            self.addSubview(messageTextView)
            self.layoutIfNeeded()
            
        }
    }
    
    
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        //    textView.text = "Sample message"
        textView.isEditable = false
       // textView.isScrollEnabled = false
       textView.isUserInteractionEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
    
    static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    
    var avatarImgUrl: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        img.backgroundColor = .blue
        return img
    }()
    var greyBubble: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = grayBubbleImage
        img.tintColor = UIColor(white: 0.90, alpha: 1)
        return img
    }()
    var myAvatar: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        img.backgroundColor = .blue
        return img
    }()
    var blueBubble: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = blueBubbleImage
        return img
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        
        
        myAvatar.removeFromSuperview()
        blueBubble.removeFromSuperview()
        self.addSubview(avatarImgUrl)
        self.addSubview(greyBubble)
        self.addSubview(messageTextView)
        // self.addSubview(blueBubble)
        
        
        
        avatarImgUrl.anchor(nil, left: self.leftAnchor, bottom: self.messageTextView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        
        [ greyBubble.leftAnchor.constraint(equalTo: self.avatarImgUrl.rightAnchor, constant:5),
          greyBubble.rightAnchor.constraint(equalTo: self.messageTextView.rightAnchor, constant: 10),
          greyBubble.topAnchor.constraint(equalTo: self.topAnchor),
          greyBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})
        
        greyBubble.image = message.grayBubbleImage
        
    }
    
    
    
    func changeReceiver() {
        
        myAvatar.removeFromSuperview()
        blueBubble.removeFromSuperview()
        self.addSubview(avatarImgUrl)
        self.addSubview(greyBubble)
        self.addSubview(messageTextView)
        // self.addSubview(blueBubble)
        
        
        
        avatarImgUrl.anchor(nil, left: self.leftAnchor, bottom: self.messageTextView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        
        [ greyBubble.leftAnchor.constraint(equalTo: self.avatarImgUrl.rightAnchor, constant:5),
          greyBubble.rightAnchor.constraint(equalTo: self.messageTextView.rightAnchor, constant: 10),
          greyBubble.topAnchor.constraint(equalTo: self.topAnchor),
          greyBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})
        
        greyBubble.image = message.grayBubbleImage
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}







