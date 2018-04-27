//
//  ChatAPIManager.swift
//  MakeItHire_ios
//
//  Created by Nik Suprunov on 4/26/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import Foundation
import Alamofire


extension APIManager {
    
    
    
    func replyTo(idChat: Int, message: String, completion: @escaping (String?) -> ()) {
        guard let url = URL(string: mainRoute + "/replyMessage") else { return }
        
        
        Alamofire.request(url, method: .post, parameters:["idChat":idChat, "Message":message],encoding: JSONEncoding.default, headers:  ["Authorization":APIManager.token]).responseJSON {
            response in
            
            switch response.result {
                
                
            case .success:
                guard let data = response.data else { return }
                
                do {
                    let response = try JSONDecoder().decode(replyResponse.self, from: data)
                    
                    
                    completion(response.message)
                    
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
    
    
    
    func getMessages(idChat: Int, completion: @escaping ([Message]?) -> ()) {
        guard let url = URL(string: mainRoute + "/getMessages") else { return }
        
        print(idChat)
        
        Alamofire.request(url, method: .post, parameters:["idChat":idChat],encoding: JSONEncoding.default, headers:  ["Authorization":APIManager.token]).responseJSON {
            response in
            
            switch response.result {
                
                
            case .success:
                guard let data = response.data else { return }
                
                do {
                    let response = try JSONDecoder().decode(ResponseMessages.self, from: data)
                    
                    
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
    
    
    
    
    
    
    
    
    
    
    func getStudentChats( completion: @escaping ([ChatWith]?) -> ()) {
        guard let url = URL(string: mainRoute + "/getStudentChats") else { return }
        

        
        Alamofire.request(url, method: .post, parameters:nil,encoding: JSONEncoding.default, headers:  ["Authorization":APIManager.token]).responseJSON {
            response in
            
            switch response.result {
                
                
            case .success:
                guard let data = response.data else { return }
                
                do {
                    let response = try JSONDecoder().decode(ResponseChat.self, from: data)
                    
                    
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
