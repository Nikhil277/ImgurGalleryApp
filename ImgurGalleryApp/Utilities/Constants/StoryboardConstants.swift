//
//  StoryboardConstants.swift

import Foundation
import UIKit

protocol StoryboardScene: RawRepresentable {
    
    static var storyboardName: String {get}
}

extension StoryboardScene {
    
    static func storyboard() -> UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    func viewController() -> UIViewController {
        // swiftlint:disable:next force_cast
        return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue as! String)
    }
    
}

extension UIStoryboard {
    
    struct Main {
        
        private enum Identifier: String, StoryboardScene {
            static let storyboardName   = "Main"
            case galleryViewController  = "GalleryViewController"
            case detailsViewController  = "DetailsViewController"
            case aboutViewController    = "AboutViewController"
        }
        
        static func galleryViewController() -> UIViewController {
            return Identifier.galleryViewController.viewController()
        }
        static func detailsViewController() -> UIViewController {
            return Identifier.detailsViewController.viewController()
        }
        static func aboutViewController() -> UIViewController {
            return Identifier.aboutViewController.viewController()
        }
    }
}
