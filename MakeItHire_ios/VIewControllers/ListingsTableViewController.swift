//
//  ListingsTableViewController.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/14/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import LBTAComponents


class ListingsTableViewController: UITableViewController {

    
    fileprivate var data = [Job]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
          // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       //  self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        APIManager.shared.getUniversitylist(completion: {(response) in
            
            if response != nil {
                APIManager.unis = response!
                
            }
            
        })
        
        APIManager.shared.getAllMajors(completion: {(response) in
            
            if response != nil {
                APIManager.majors = response!
            }
            
            
        })
        
        
        view.backgroundColor = .white
        tableView.register(ListingCell.self, forCellReuseIdentifier: "listing")
        navigationItem.title = "Home"
        
        updateData()
        
    }
    
    
    func updateData() {
        APIManager.shared.getAllCompaniesWithJobs(completion: {(response) in
            
            if(response != nil) {
                
            self.data = response!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listing", for: indexPath) as! ListingCell

        // Configure the cell...
        
        
        cell.companyNameLabel.text = data[indexPath.row].CompanyName
        cell.deadlineLabel.text = data[indexPath.row].Deadline
        cell.jobTitleLabel.text = data[indexPath.row].JobName

        return cell
    }

}


class ListingCell: UITableViewCell {
    
    
    let companyNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = UIColor(displayP3Red: 76/255, green: 125/255, blue: 190/255, alpha: 1)

        return label
        
    }()
    
    let deadlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        return label
    
    }()
    
    let jobTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "TimesNewRomanPSMT", size: 28.0)

        return label
        
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        self.addSubview(companyNameLabel)
        self.addSubview(deadlineLabel)
        self.addSubview(jobTitleLabel)
        
        
        companyNameLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        deadlineLabel.anchor(self.companyNameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 30)
        
        jobTitleLabel.anchor(deadlineLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 50)
        
        companyNameLabel.text = "Amazon Company"
        deadlineLabel.text = "04/09/2018"
        jobTitleLabel.text = "Front-End Developer"
        
    }
}
