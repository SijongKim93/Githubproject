//
//  Model.swift
//  GithubProJect
//
//  Created by 김시종 on 4/17/24.
//

import UIKit

struct GithubUser: Decodable {
    let login: String
    let name: String
    let avatarUrl: String
    let bio: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case avatarUrl = "avatar_url"
        case bio
    }
}
