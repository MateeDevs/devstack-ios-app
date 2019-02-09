//
//  DynamicTabViewController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 14/09/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

protocol TabViewControllerDelegate: class {
    func setContainerHeight(_ height: CGFloat)
}

class TabViewController: BaseViewController {
    weak var tabDelegate: TabViewControllerDelegate?
    
    func isNearBottomEdge() {
    }
    
    func pullToRefresh() {
    }
}
