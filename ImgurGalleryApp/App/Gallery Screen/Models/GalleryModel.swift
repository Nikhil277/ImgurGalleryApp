//
//  GalleryModel.swift
//  ImgurGalleryApp
//
//  Created by Nikhil B Kuriakose on 05/05/21.
//

import Foundation

struct GalleryModel: Codable {
    var imageUrl, title, description: String
    var isViral: Bool

    var dictionary: [String: Any] {
        return [
            "imageUrl": imageUrl,
            "title": title,
            "description": description,
            "isViral": isViral,
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}

enum GalleryFilter {
    case hot
    case top
    case user
}
