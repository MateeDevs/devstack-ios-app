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
    
    public func startActivityIndicator(style: UIActivityIndicatorView.Style = .whiteLarge, color: UIColor = ColorTheme.mainColor, backgroundColor: UIColor = .clear) {
        endEditing(true)
        stopActivityIndicator()
        let activityIndicatorView = ActivityIndicatorView()
        activityIndicatorView.indicator.style = style
        activityIndicatorView.indicator.color = color
        activityIndicatorView.backgroundView.backgroundColor = backgroundColor
        activityIndicatorView.setConstraintsToCoverView(self)
    }
    
    public func stopActivityIndicator() {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
    public var isLoading: Bool {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                return true
            }
        }
        return false
    }
    
    // MARK: Constraints
    
    /// Constraints to view bounds
    public func setConstraintsToCoverView(_ containerView: UIView) {
        containerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
    }
    
    /// Constraints to center in view
    public func setConstraintsToCenterInView(_ containerView: UIView) {
        containerView.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
}
