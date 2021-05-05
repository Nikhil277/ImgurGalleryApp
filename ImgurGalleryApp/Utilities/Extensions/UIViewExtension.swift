//
//  UIViewExtension.swift
//
//  Created by Nikhil B Kuriakose on 03/05/21.
//  Copyright © 2020 ArmiaSystems. All rights reserved.
//

import UIKit

// MARK: - View
extension UIView {
    // MARK: fromNib
    static func fromNib<T: UIView>() -> T {
        // swiftlint:disable:next force_cast
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    /// Returns a collection of constraints to anchor the bounds of the current view to the given view.
    ///
    /// - Parameter view: The view to anchor to.
    /// - Returns: The layout constraints needed for this constraint.
    func constraintsForAnchoringTo(boundsOf view: UIView) -> [NSLayoutConstraint] {
        return [
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
    }

    func animateLabel(_ duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .fade
        animation.subtype = .fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }

    func shadowRound() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.size.width/2).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func shadowTopWithCornerRadius(_ cornerRadius: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        let shadowPath2 = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath2
    }

    func shadowBottomWithCornerRadius(_ cornerRadius: CGFloat = 0, opacity: Float = 0.5, height: CGFloat = 1.0) {
        self.layer.cornerRadius = cornerRadius
        let shadowPath2 = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath2
    }

    func shadowRightBottomWithCornerRadius(_ cornerRadius: CGFloat = 0, opacity: Float = 0.3, widthOffset: CGFloat = 2.0, heightOffset: CGFloat = 2.0) {
        self.layer.cornerRadius = cornerRadius
        let shadowPath2 = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(widthOffset), height: CGFloat(heightOffset))
        self.layer.shadowOpacity = opacity
        self.layer.shadowPath = shadowPath2
    }

    func removeShadow () {
        self.layer.shadowPath = nil
    }

    // updated

    func shadowAllSide(_ cornerRadius: CGFloat = 0, color: UIColor = .black) {
        self.layer.cornerRadius = cornerRadius
        let shadowPath2 = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(0.0))
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = shadowPath2
    }

    // MARK: animateView
    func animateView(_ subtype: String, _ duration: Float = 0.5, completion: @escaping() -> Void) {
        let transition: CATransition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype(rawValue: subtype)
        self.layer.add(transition, forKey: kCATransition)
        completion()
    }

    // MARK: Specific corner radius
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
   func createCircleAnimation(duration: TimeInterval, radius: CGFloat = 0) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = true
        
        let progressLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.height / 2.0) + radius, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        progressLayer.path = circularPath.cgPath
        progressLayer.name = "circleAnimation"
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 4.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(progressLayer)
        progressLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }
    
    func removeCircleAnimation() {
        guard self.layer.sublayers?.count ?? 0 > 0 else {
            return
        }
        for layer in self.layer.sublayers! {
            if layer.name == "circleAnimation" {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
    }
    
    func removeBlurEffect() {
        let blurredEffectViews = self.subviews.filter{$0 is UIVisualEffectView}
        blurredEffectViews.forEach{ blurView in
            blurView.removeFromSuperview()
        }
    }
}
