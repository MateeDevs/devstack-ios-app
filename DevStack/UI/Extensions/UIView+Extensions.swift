//
//  UIView+Extensions.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 03/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Activity Indicator on view
    
    func startActivityIndicator(style: UIActivityIndicatorView.Style = .whiteLarge, color: UIColor = ColorTheme.mainColor, backgroundColor: UIColor = UIColor.clear) {
        endEditing(true)
        stopActivityIndicator()
        let activityIndicatorView = ActivityIndicatorView()
        activityIndicatorView.indicator.style = style
        activityIndicatorView.indicator.color = color
        activityIndicatorView.backgroundView.backgroundColor = backgroundColor
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        ConstraintsHelper.setConstraintToCoverView(containerView: self, view: activityIndicatorView)
    }
    
    func stopActivityIndicator() {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                view.removeFromSuperview()
            }
        }
    }
    
    func isLoading() -> Bool {
        for view in subviews {
            if view.isKind(of: ActivityIndicatorView.self) {
                return true
            }
        }
        return false
    }
    
}
