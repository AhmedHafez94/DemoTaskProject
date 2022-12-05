//
//  ViewController.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var albumsTV: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let viewModel = ProfileViewModel()
    var user: User?
    var userAlbums: [Album] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        getUserData()
        setupTableview()
    }
    
    func setupTableview() {
        albumsTV.dataSource = self
        albumsTV.delegate = self
    }
    
    func getUserData() {
        viewModel.getUser { [weak self] (user) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.setupUserData(user: user)
            }
        }
        
        viewModel.getUserAlbums { [weak self] (albums) in
            guard let self = self else {return}
            self.userAlbums = albums
            print("albums in vc \(albums)")
            DispatchQueue.main.async {
                self.albumsTV.reloadData()
            }
        }
    }
    
    func setupUserData(user: User?) {
        usernameLabel.text = user?.name
        let address = user?.address
        addressLabel.text = " \(address?.street ?? ""), \(address?.suite ?? ""), \(address?.city ?? "") \(address?.zipcode ?? "")"
    }
    
    func goToAlbumeDetails(albumId: Int) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let destVC = sb.instantiateViewController(identifier: "AlbumDetailsViewController") as! AlbumDetailsViewController
        destVC.albumId = albumId
        navigationController?.pushViewController(destVC, animated: true)
    }


}

//MARK: Tableview methods

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAlbums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(userAlbums[indexPath.row].title)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = userAlbums[indexPath.row]
        // do somethinfg with selected album
        goToAlbumeDetails(albumId: selectedAlbum.id)
    }
    
    
    
}
