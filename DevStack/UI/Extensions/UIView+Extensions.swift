//
//  UIView+Extensions.swift
//  DevStack
//
//  Created by Petr Chmelar on 03/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

extension UIView {
    
    public func startActivityIndicator(style: UIActivityIndicatorView.Style = .whiteLarge, color: UIColor = ColorTheme.mainColor, backgroundColor: UIColor = .clear) {
        endEditing(true)
        stopActivityIndicator()
        
        let activityIndicatorView = ActivityIndicatorView()
        activityIndicatorView.indicator.style = style
        activityIndicatorView.indicator.color = color
        activityIndicatorView.backgroundView.backgroundColor = backgroundColor
        
        addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor).isActive = true
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
    
}
