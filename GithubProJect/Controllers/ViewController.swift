//
//  ViewController.swift
//  GithubProJect
//
//  Created by 김시종 on 4/17/24.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher



class ViewController: UIViewController {
    
    let networkingManager = NetworkingManager()
    var userInfo: GithubUser?
    var userRepo: [GithubRepository] = []

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var akaLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        fetchUserData()
        fetchUserRepo()
        
    }
    
    func fetchUserData() {
        networkingManager.fetchUser { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.userInfo = user
                DispatchQueue.main.async {
                    self.updataUserUI(with: user)
                }
            case .failure(let error):
                print("데이터를 가져오는데 실패했습니다: \(error)")  // 예외처리는 이용자도 어떤게 실패한건지 알 수 있게
            }
        }
    }
    
    func updataUserUI(with user: GithubUser) {
        nameLabel.text = user.login
        akaLabel.text = user.name
        introduceLabel.text = user.bio
        
        let imageUrlString = user.avatarUrl
        if let imageUrl = URL(string: imageUrlString) {
            mainImage.kf.setImage(with: imageUrl)
            mainImage.layer.cornerRadius = mainImage.frame.width / 2
            mainImage.clipsToBounds = true
        } else {
            print("실패했습니다.")
        }
    }
    
    
    func fetchUserRepo() {
        networkingManager.fetchRepo { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let repo):
                self.userRepo = repo
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case.failure(let error):
                print("데이터 가져오는데 실패: \(error)")
            }
        }
    }
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("오류")
        }
        
        let repo = userRepo[indexPath.row]
        
        cell.cellTitle.text = repo.name
        cell.cellDescription.text = repo.description
        
        return cell
    }
}
