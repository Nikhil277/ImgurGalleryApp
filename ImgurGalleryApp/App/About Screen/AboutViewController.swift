//
//  AboutViewController.swift
//  ImgurGalleryApp
//
//  Created by Nikhil B Kuriakose on 05/05/21.
//

import UIKit

class AboutViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var appVersionLabel: UILabel!
    @IBOutlet weak var buildNumberLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            appVersionLabel.text = "App Version:- \(appVersion)"
        }
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            buildNumberLabel.text = "Build:- \(buildNumber)"
        }
        
        timeLabel.text = getDateString()
    }

    // MARK: - Custom Methods
    func getDateString() -> String? {
        let formatter = DateFormatter()
        formatter.isLenient = true
        formatter.dateFormat = "hh:mm a"

        let corrected = formatter.string(from: Date())
        return corrected
    }

}
