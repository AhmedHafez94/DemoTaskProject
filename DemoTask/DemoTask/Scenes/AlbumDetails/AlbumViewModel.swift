//
//  AlbumViewModel.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import Foundation
import Alamofire


struct AlbumViewModel {

    func fetchAlbumData(albumId: Int, completion: @escaping (_ albumData: [AlbumData]) -> Void) {
        let baseUrl = "https://jsonplaceholder.typicode.com/albums/\(albumId)/photos"
        AF.request(baseUrl).responseDecodable(of: [AlbumData].self) { (response) in
            print("get user data will be printed")
            switch response.result {
            case .failure(let error):
                print("error while get album data  \(error.localizedDescription)")
                completion([])
                
            case .success(let albumData):
                print("success get album data \(albumData)")
                completion(albumData)
                
            }
        }
    }
    
}
