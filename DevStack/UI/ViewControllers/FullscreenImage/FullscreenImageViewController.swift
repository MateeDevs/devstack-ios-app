//
//  FullscreenImageViewController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 16/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

class FullscreenImageViewController: BaseViewController {
    
    var url: URL?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        activityIndicator.color = ColorTheme.mainColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let url = url else { return }
        imageView.af_setImage(withURL: url)
    }
}

extension FullscreenImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // Center content of scrollView
        // Idea taken from: http://stackoverflow.com/questions/1316451/center-content-of-uiscrollview-when-smaller
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
    
}
