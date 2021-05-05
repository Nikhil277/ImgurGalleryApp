//
//  GalleryViewModel.swift
//  ImgurGalleryApp
//
//  Created by Nikhil B Kuriakose on 05/05/21.
//

import Foundation
import Alamofire

protocol GalleryViewModelDelegate: AnyObject {
    func apiCallStatus(_ status: Bool)
}

class GalleryViewModel {
    weak var delegate: GalleryViewModelDelegate?
    var galleryData = [GalleryModel]()
    func fetchGalleryList(_ viral: String, type: GalleryFilter) {
        var typeString = "hot"
        switch type {
        case .hot:
            typeString = "hot"
        case .top:
            typeString = "top"
        case .user:
            typeString = "user"
        }
        let request = AF.request("https://api.imgur.com/3/gallery/\(typeString)/viral/\(viral).json", headers: ["Authorization": "fd194eb4c4a61b8"])
        request.responseJSON { (data) in
            if let jsonData = data.value as? [String: Any] {
                if let status = jsonData["status"] as? Int, status == 200 {
                    if let parsedData = jsonData["data"] as? [[String: Any]] {
                        print(parsedData)
                        // appending images in each section
                        // It seems all images I checked in postman on a quick looks seems to be not viral
                        // title and description seems to be null for all that I checked.
                        // So providing a dummy title & description in case not available for having something to display
                        self.parseGalleryData(parsedData)
                    }
                }
            }
        }
    }
    
    func parseGalleryData(_ galleryData: [[String: Any]]) {
        self.galleryData.removeAll()
        for data in galleryData {
            if let images = data["images"] as? [[String: Any]] {
                for imageData in images {
                    let imageUrl = imageData["link"] as? String ?? ""
                    let title = imageData["title"] as? String ?? ""
                    let description = imageData["description"] as? String ?? ""
                    let isViral = imageData["in_most_viral"] as? Bool ?? false
                    let tempData = GalleryModel(imageUrl: imageUrl, title: title, description: description, isViral: isViral)
                    self.galleryData.append(tempData)
                }
            }
        }
        delegate?.apiCallStatus(true)
    }
}
