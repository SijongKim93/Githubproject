//
//  NetworkingManager.swift
//  GithubProJect
//
//  Created by 김시종 on 4/17/24.
//

import UIKit
import Alamofire


final class NetworkingManager {
    let url = "https://api.github.com/users/SijongKim93"
    
    func fetchUser(completion: @escaping ((Result<GithubUser, Error>) -> Void)) {
        let url = "\(self.url)"
        
        AF.request(url).responseDecodable(of: GithubUser.self) { response in
            switch response.result {
            case .success(let user):
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    let urlreop = "https://api.github.com/users/SijongKim93/repos"
    
    func fetchRepo(completion: @escaping (Result<[GithubRepository], Error>) -> Void) {
        let urlRepo = "\(self.urlreop)"
        
        AF.request(urlRepo).responseDecodable(of: [GithubRepository].self) { response in
            switch response.result {
            case .success(let repo):
                completion(.success(repo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
