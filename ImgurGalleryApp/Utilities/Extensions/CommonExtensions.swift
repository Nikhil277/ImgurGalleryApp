//
//  CommonExtensions.swift

import Foundation
import UIKit

// MARK: - UIColor Extension

extension UIColor {
    /**
     To get UIColor from hex string.
     - parameter hex: Hex value of color code.
     */
    convenience init(hex: String) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

// MARK: - UserDefaults Extension

extension UserDefaults {

    func setStringValueFor (key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getStringValueFor (key: String) -> String {
        let value = UserDefaults.standard.string(forKey: key)
        return (value == nil) ? "" : value!
    }

    func setCustomObjectFor (key: String, value: Data) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getCustomObjectFor (key: String) -> Data? {
        if let value = UserDefaults.standard.object(forKey: key) as? Data {
            return value
        }
        return nil
    }

    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "IsLoggedIn")
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: "IsLoggedIn")
    }
    
    func decode<T: Codable>(for type: T.Type, using key: String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {return nil}
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }

    func encode<T: Codable>(for type: T, using key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}

// MARK: - Date

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return years(from: date) > 1 ? "\(years(from: date)) years ago" : "\(years(from: date)) year ago" }
        if months(from: date)  > 0 { return months(from: date) > 1 ? "\(months(from: date)) months ago" : "\(months(from: date)) month ago"  }
        if weeks(from: date)   > 0 { return weeks(from: date) > 1 ? "\(weeks(from: date)) weeks ago" : "\(weeks(from: date)) week ago"   }
        if days(from: date)    > 0 { return days(from: date) > 1 ? "\(days(from: date)) days ago" : "\(days(from: date)) day ago"    }
        if hours(from: date)   > 0 { return hours(from: date) > 1 ? "\(hours(from: date)) hours ago" : "\(hours(from: date)) hour ago"   }
        if minutes(from: date) > 0 { return minutes(from: date) > 1 ? "\(minutes(from: date)) minutes ago" : "\(minutes(from: date)) minute ago" }
        if seconds(from: date) > 0 { return "Just now" }
        return ""
    }
    
    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }
        return "\(secondsAgo / week) weeks ago"
    }
    
    func getElapsedInterval() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"

        }

    }
}

// MARK: - Viewcontroller

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UICollectionViewCell {
    func addShadow(_ radius: CGFloat = 6) {
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        layer.cornerRadius = radius
    }
    
    func addCornerRadius(_ radius: CGFloat = 6) {
        contentView.layer.cornerRadius = radius
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
    }
}

extension UIViewController {
    func showToast(message: String, _ timer: Double = 0.5) {
       let height = heightForView(text: message, font: UIFont.systemFont(ofSize: 12), width: self.view.frame.size.width - 60)
        let toastLabel = UILabel(frame: CGRect(x: 20, y: self.view.frame.size.height - 120, width: self.view.frame.size.width - 40, height: height + 20))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.font =  UIFont.systemFont(ofSize: 12)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: timer, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        
        return label.frame.height
    }
    
}

// MARK: - UIResponder

extension UIResponder {
  
  func getOwningViewController() -> UIViewController? {
    var nextResponser = self
    while let next = nextResponser.next {
      nextResponser = next
      if let viewController = nextResponser as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}

// MARK: - Notifications

extension Notification.Name {
    static let didUpdateVideoTime = Notification.Name("UpdateVideoProgressTime")
    static let didUpdateBufferStatus = Notification.Name("VideBufferStatus")
    static let didUpdateHomeLikeStatus = Notification.Name("HomeLikeStatus")
    static let didUpdateBookMark = Notification.Name("HomeBookmarkStatus")
    static let didUpdateUserFollowingStatus = Notification.Name("UserFollowingStatus")
    static let didTriggerGetFeedbackAction = Notification.Name("GetFeedbcakAction")
    static let didTapDynamicLinks = Notification.Name("DynamicLinkClicked")
    static let locationPermissionUpdated = Notification.Name("LocationPermissionUpdated")
    static let userLocationUpdated = Notification.Name("UserLocationUpdated")
    static let didTriggerShowcaseVideoRemoveAction = Notification.Name("ShowcaseVideoRemoved")
    static let didTriggerShowcaseCreateVideoAction = Notification.Name("CreateVideoFromProfile")
    static let didTriggerProfileBackFromNotifications = Notification.Name("ProfileBackFromNotification")
    static let didTriggerShowReelProcessedAction = Notification.Name("ShowReelProcessed")
    static let updateUploadProgress = Notification.Name("VideosUploadProgress")
}

// MARK: - Int

extension Int {
    func formatUsingAbbrevation () -> String {
        var num: Double = Double(self)
        let sign = ((num < 0) ? "-" : "" )

        num = fabs(num)

        // up until thousand there will be like 123, 999 etc
        // after thousand it won't be in 3 digits. Example instead of 123k it will be 0.1m
        if num < 1000.0 {
            return "\(sign)\(Int(num))"
        } else if num < 100000.0 {
            let roundedNum: Double = round(10 * num / 1000) / 10
            return "\(sign)\(roundedNum)k"
        } else if num < 100000000 {
            let roundedNum: Double = round(10 * num / 1000000) / 10
            return "\(sign)\(roundedNum)m"
        } else if num < 100000000000 {
            let roundedNum: Double = round(10 * num / 1000000000) / 10
            return "\(sign)\(roundedNum)b"
        }

        let exp: Int = Int(log10(num) / 2.0 )

        let units: [String] = ["K", "M", "G", "T", "P", "E"]

        let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10

        return "\(sign)\(roundedNum)\(units[exp-1])"
    }
}

extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}

extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
