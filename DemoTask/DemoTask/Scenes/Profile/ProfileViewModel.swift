//
//  ProfileViewModel.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import Foundation
import Alamofire


struct ProfileViewModel {
    let userId = Int.random(in: 1...10)
    
    func getUser(completion: @escaping (_ user: User?) -> Void) {
        let baseUrl = "https://jsonplaceholder.typicode.com/users/\(userId)"
        AF.request(baseUrl).responseDecodable(of: User.self) { (response) in
            print("get user data will be printed")
            switch response.result {
            case .failure(let error):
                print("error while get user \(error.localizedDescription)")
                completion(nil)
            case .success(let user):
                print("success get user \(user)")
                completion(user)
            }
        }
    }
    
    func getUserAlbums(completion: @escaping (_ albums: [Album]) -> Void) {
        let baseUrl = "https://jsonplaceholder.typicode.com/users/\(userId)/albums"
        
        AF.request(baseUrl).responseDecodable(of: [Album].self) { (response) in
            switch response.result {
            case .success(let albums):
                print("success get user albumes \(albums)")
                completion(albums)
            case .failure(let error):
                print("error get user albums \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
   
}
