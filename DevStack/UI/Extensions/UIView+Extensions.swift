//
//  UIView+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 03/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Activity Indicator on view
    
    public func startActivityIndicator(style: UIActivityIndicatorView.Style = .whiteLarge, color: UIColor = ColorTheme.mainColor, backgroundColor: UIColor = UIColor.clear) {
        endEditing(true)
        stopActivityIndicator()
        let activityIndicatorView = ActivityIndicatorView()
        activityIndicatorView.indicator.style = style
        activityIndicatorView.indicator.color = color
        activityIndicatorView.backgroundView.backgroundColor = backgroundColor
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.setConstraintsToCoverView(self)
    }
    
    public func stopActivityIndicator() {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
    public func isLoading() -> Bool {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                return true
            }
        }
        return false
    }
    
    // MARK: Constraints
    
    // Constraints to view bounds
    public func setConstraintsToCoverView(_ containerView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(self)
        let horConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let verConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let widConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heiConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal,toItem: containerView, attribute: .height,multiplier: 1.0, constant: 0.0)
        containerView.addConstraints([horConstraint, verConstraint, widConstraint, heiConstraint])
    }
    
    // Constraints to center in view
    public func setConstraintsToCenterInView(_ containerView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(self)
        let horConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let verConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        containerView.addConstraints([horConstraint, verConstraint])
    }
    
}
