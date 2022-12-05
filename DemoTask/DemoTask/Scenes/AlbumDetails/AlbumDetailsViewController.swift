//
//  AlbumDetailsViewController.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import UIKit
import SKPhotoBrowser

class AlbumDetailsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosCV: UICollectionView!
    
    var albumId = 0
    var viewModel = AlbumViewModel()
    var displayedAlbumData: [AlbumData] = []
    var albumDataArr: [AlbumData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Album details"
        setupCollectionView()
        searchBar.delegate = self
        fetchAlbumData()
       
    }
    
    
    func setupCollectionView() {
        photosCV.dataSource = self
        photosCV.delegate = self
        photosCV.register(UINib(nibName: "PhotoCVC", bundle: nil), forCellWithReuseIdentifier: "PhotoCVC")
        photosCV.collectionViewLayout = createThreeColumnFlowLayout()
    }
    
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minmumItemSpacing: CGFloat = 0
        let availableWidth = width - (padding * 2) - (minmumItemSpacing * 2)
        let itemWidth = width / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        return flowLayout
    }
    
    func fetchAlbumData() {
        activityIndicator.startAnimating()
        viewModel.fetchAlbumData(albumId: self.albumId) { [weak self] (albumData) in
            guard let self = self else {return}
            self.activityIndicator.isHidden = true
            self.albumDataArr = albumData
            self.displayedAlbumData = albumData
            DispatchQueue.main.async {
                self.photosCV.reloadData()
            }
        }
    }
    
    
    func displayImage(url: String) {
        // 1. create URL Array
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImageURL(url)
        photo.shouldCachePhotoURLImage = true
        images.append(photo)

        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        present(browser, animated: true, completion: {})
    }

    

}

//MARK: ->  Collectionview methods

extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedAlbumData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
        cell.configure(url: displayedAlbumData[indexPath.row].url)
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImgUrl = displayedAlbumData[indexPath.row].url
        displayImage(url: selectedImgUrl)
    }
 
}

//MARK: -> UISearchBarDelegate

extension AlbumDetailsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText will be printed \(searchText)")
        if searchText == "" {
            displayedAlbumData = albumDataArr
        } else {
            let filteredFowllowers = albumDataArr.filter({ (albumDataElement) -> Bool in
                albumDataElement.title.lowercased().contains(searchText.lowercased())
            })
            displayedAlbumData = filteredFowllowers
        }
        DispatchQueue.main.async {
            self.photosCV.reloadData()
        }
    }
}
