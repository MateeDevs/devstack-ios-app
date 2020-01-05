//
//  WhisperView.swift
//  DevStack
//
//  Created by Petr Chmelar on 19/04/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import UIKit

public enum WhisperStyle {
    case info,success,error
    
    public var color: UIColor {
        switch self {
        case .info: return AppTheme.Colors.alertBackgroundInfo
        case .success: return AppTheme.Colors.alertBackgroundSuccess
        case .error: return AppTheme.Colors.alertBackgroundError
        }
    }
}

class WhisperView: UIView {
    
    private let messageLabel = UILabel()
    
    public var message: String = "" {
        didSet {
            messageLabel.text = message
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        messageLabel.textAlignment = .center
        messageLabel.textColor = AppTheme.Colors.alertMessage
        messageLabel.font = AppTheme.Fonts.alertMessage
        
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
