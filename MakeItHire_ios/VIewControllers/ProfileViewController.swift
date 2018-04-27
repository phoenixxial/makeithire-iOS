//
//  ProfileViewController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/14/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import LBTAComponents

class ProfileViewController: UIViewController {

    
  
    fileprivate static let blueCol = UIColor(displayP3Red: 76/255, green: 125/255, blue: 190/255, alpha: 1)

    
    
    var userForInfo: User? {
        didSet {
            
            
            //TODO: Paragraph allignment = center is not working.
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            
            let strokeTextAttributes = [
                NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
                ] as [NSAttributedStringKey : Any]
            
            let additionalTextAttributes = [
                NSAttributedStringKey.foregroundColor : UIColor.darkGray,
                NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),
                NSAttributedStringKey.paragraphStyle: paragraph
                ] as [NSAttributedStringKey : Any]
            
            
            if let m = APIManager.user.EmailID {
                let attributedText = NSMutableAttributedString(string: "Email: ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: m, attributes: additionalTextAttributes))
                email.attributedText = attributedText
                
                
            }
            if let n = APIManager.user.LastName {
                let attributedText = NSMutableAttributedString(string: "Name: ", attributes: strokeTextAttributes)
                
                
                if let f = APIManager.user.FirstName {
                       attributedText.append(NSAttributedString(string: f+" ", attributes: additionalTextAttributes))
                }
                 attributedText.append(NSAttributedString(string: n, attributes: additionalTextAttributes))
                name.attributedText = attributedText
            }
            
            if let u = userForInfo?.University {
                if let uni = APIManager.unis[u].UnivName {
                
                let attributedText = NSMutableAttributedString(string: "University: ", attributes: strokeTextAttributes)
                 attributedText.append(NSAttributedString(string: uni, attributes: additionalTextAttributes))
                university.attributedText = attributedText
            }
            }
            
            if (userForInfo?.Major)!-1 > -1 && (userForInfo?.Major)!-1 < APIManager.majors.count {
            if let m = APIManager.majors[(userForInfo?.Major)!-1].MajorName {
                let attributedText = NSMutableAttributedString(string: "Major: ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: m, attributes: additionalTextAttributes))
                major.attributedText = attributedText
            }
            }
            
            if let p = userForInfo?.PhoneNumber {
                let attributedText = NSMutableAttributedString(string: "Phone: ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: p, attributes: additionalTextAttributes))
                phone.attributedText = attributedText
            }
            
            if let b = userForInfo?.Bio {
                let attributedText = NSMutableAttributedString(string: "Bio:\n ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: b, attributes: additionalTextAttributes))
                bio.attributedText = attributedText
                
            }
            
            if let lin = userForInfo?.Links {
                let attributedText = NSMutableAttributedString(string: "Links:\n ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: lin, attributes: additionalTextAttributes))
                links.attributedText = attributedText
            }
            
            if let proj = userForInfo?.Projects {
                let attributedText = NSMutableAttributedString(string: "Projects:\n ", attributes: strokeTextAttributes)
                attributedText.append(NSAttributedString(string: proj, attributes: additionalTextAttributes))
                projects.attributedText = attributedText
                
            }
            
        }
        
    }
    
    
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.darkGray
        return v
    }()
    
    

    var temp =  UITextView()
    
    let name: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Name: "
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
    }()
    
    let email: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Email: "
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        
        return field
    }()
    
    let university: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "University: "
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
    }()
    
    
    let phone: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Phone: "
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
    }()
    
    let major: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Major: "
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
    }()
    
    
    
    let links: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Related Links: \n"
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
        
    }()
    
    let projects: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Projects: \n"
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
        
    }()
    let bio: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        let text = "Bio: \n"
        let strokeTextAttributes = [
            NSAttributedStringKey.foregroundColor : ProfileViewController.blueCol,
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        let attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
        field.attributedText = attributedText
        field.isEditable = false
        field.isSelectable = false
        return field
        
    }()
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: view.frame.width, height: bio.frame.origin.y + bio.frame.height+10)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        APIManager.shared.getProfileDetails() {(user) in
            if user != nil {
                APIManager.userDetailed = user
                self.userForInfo = user
                
            }
        }
        
        setupUI()
    }
    
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
