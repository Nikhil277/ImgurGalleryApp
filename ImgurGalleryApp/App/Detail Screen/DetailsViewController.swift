//
//  DetailsViewController.swift
//  ImgurGalleryApp
//
//  Created by Nikhil B Kuriakose on 05/05/21.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var galleryDescription: UILabel!
    @IBOutlet weak var galleryTitle: UILabel!
    @IBOutlet weak var galleryImage: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Button Actions
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
