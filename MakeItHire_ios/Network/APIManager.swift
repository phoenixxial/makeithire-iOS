//
//  APIManager.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/13/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import Alamofire


class APIManager {
    
    
    fileprivate let localRoute = "http://localhost:3000/api"

    let mainRoute = "https://makeithire-node.herokuapp.com/api"

    static var shared: APIManager = APIManager()
    static var token = String()
    static var user: User!
    static var userDetailed: User!

    static var unis = [Uni]()
    static var majors = [Major]()
    
    
    
    

    
    
    
    
    
    func logmein(login: String?, pass: String?, completion: @escaping (Response?) -> ()) {
        guard let url = URL(string: mainRoute + "/login") else { return }
        
        guard let login = login else { return }
        guard let pass = pass else { return }
        
        Alamofire.request(url, method: .post, parameters: ["EmailID": login, "Password":pass],encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
        
            switch response.result {
                
            case .success:
                guard let data = response.data else { return }
                
                do {
                    
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    
                    completion(response)
                
                }
                    
                catch let jsonErr {
                    print("Error initializing json:",jsonErr)
                    completion(nil)
                }
                
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    
    
    
    
    
    func getUniversitylist(completion: @escaping ([Uni]?) -> ()) {
        
        guard let url = URL(string: mainRoute + "/getUniversityList" ) else { return }
        
        Alamofire.request(url, method: .get, parameters: nil,encoding: JSONEncoding.default, headers:
            ["Authorization":APIManager.token]).responseJSON {
                response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    
                    do {
                        let response = try JSONDecoder().decode(Response3.self, from: data)
                        completion(response.response)
                    }
                        
                        
                    catch let jsonErr {
                        print("Error initializing json:",jsonErr)
                        completion(nil)
                    }
                    
                case .failure(_):
                    completion(nil)
                }
        }
    }
    
    
    func getAllCompaniesWithJobs(completion: @escaping ([Job]?) -> ()) {

        guard let url = URL(string: mainRoute + "/getEveryJobAndDetail" ) else { return }

        Alamofire.request(url, method: .get, parameters: nil,encoding: JSONEncoding.default, headers:
        ["Authorization":APIManager.token]).responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    completion(response.response)
                }
                    
                    
                catch let jsonErr {
                    print("Error initializing json:",jsonErr)
                    completion(nil)
                }
                
            case .failure(_):
                completion(nil)
            }
        }
    }
    func getAllMajors(completion: @escaping ([Major]?) -> ()) {
        
        guard let url = URL(string: mainRoute + "/getMajors" ) else { return }
        
        Alamofire.request(url, method: .get, parameters: nil,encoding: JSONEncoding.default, headers:
            ["Authorization":APIManager.token]).responseJSON {
                response in
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    
                    do {
                        let response = try JSONDecoder().decode(Response4.self, from: data)
                        completion(response.response)
                    }
                        
                        
                    catch let jsonErr {
                        print("Error initializing json:",jsonErr)
                        completion(nil)
                    }
                    
                case .failure(_):
                    completion(nil)
                }
        }
    }
    
    func getProfileDetails( completion: @escaping (User?) -> ()) {

        guard let url = URL(string: mainRoute + "/getStudentDetails" ) else { return }

        
        Alamofire.request(url, method: .get, parameters: nil ,encoding: JSONEncoding.default, headers:
            ["Authorization":APIManager.token]).responseJSON {
                (response) in
                
            
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        let response = try JSONDecoder().decode(Response2.self, from: data)
                        completion(response.response)
                    }
                        
                        
                    catch let jsonErr {
                        print("Error initializing json:",jsonErr)
                        completion(nil)
                    }
                    
                case .failure(_):
                    completion(nil)
                }
        }
    }
}
