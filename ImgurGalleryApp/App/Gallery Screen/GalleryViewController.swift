//
//  GalleryViewController.swift
//  ImgurGalleryApp
//
//  Created by Nikhil B Kuriakose on 05/05/21.
//

import UIKit

class GalleryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    @IBOutlet weak var hotButton: UIButton!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var viralButton: UIButton!
    
    // MARK: - Variables
    private var galleryViewModel = GalleryViewModel()
    private var galleryList = [GalleryModel]()
    private var selectedFilter: GalleryFilter = .hot
    private var isViral = "0"

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        galleryViewModel.delegate = self
        galleryViewModel.fetchGalleryList(isViral, type: selectedFilter)
    }
    
    // MARK: - Custom Methods
        
    func markAllButtonsUnselected() {
        hotButton.backgroundColor = .white
        topButton.backgroundColor = .white
        userButton.backgroundColor = .white
    }
    
    // MARK: - Button Actions
    @IBAction func filterOptions(_ sender: UIButton) {
        if sender.tag == 4 {
            if isViral == "0" {
                viralButton.backgroundColor = .blue
            } else {
                viralButton.backgroundColor = .white
            }
            isViral = isViral == "0" ? "1" : "0"
        } else if sender.tag == 3 {
            selectedFilter = .user
            markAllButtonsUnselected()
            userButton.backgroundColor = .blue
        } else if sender.tag == 2 {
            selectedFilter = .top
            markAllButtonsUnselected()
            topButton.backgroundColor = .blue
        } else if sender.tag == 1 {
            selectedFilter = .hot
            markAllButtonsUnselected()
            hotButton.backgroundColor = .blue
        }
        galleryViewModel.fetchGalleryList(isViral, type: selectedFilter)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        let cellData = galleryList[indexPath.row]
        cell.galleryImage.setImage(cellData.imageUrl, placeholder: #imageLiteral(resourceName: "placeholder-image"))
        cell.title.text = cellData.title != "" ? cellData.title : "Title \(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 40 - 10) / 2
        return CGSize(width: width, height: width)
    }
}


extension GalleryViewController: GalleryViewModelDelegate {
    func apiCallStatus(_ status: Bool) {
        if status {
            DispatchQueue.main.async {
                self.galleryList = self.galleryViewModel.galleryData
                self.galleryCollectionView.reloadData()
            }
        } else {
            
        }
    }
}
