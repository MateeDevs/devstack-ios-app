//
//  RatingView.swift
//  Shipvio2
//
//  Created by Viktor Kaderabek on 07/03/2017.
//  Copyright © 2017 Qest. All rights reserved.
//

import UIKit

protocol RatingViewDelegate: class {
    func ratingHasChanged(value: Int)
}

@IBDesignable class RatingView: XIBView {
    
    override var nibName : String {
        return RatingView.nameOfClass
    }
    
    @IBInspectable var minimumRequiredStar : Int = 1
    
    @IBInspectable var starDefaultColor : UIColor = Asset.Colors.star.color {
        didSet {
            paintStars()
        }
    }
    @IBInspectable var starEmptyColor: UIColor =  Asset.Colors.starEmpty.color {
        didSet {
            paintEmptyStars()
        }
    }
    
    weak var ratingDelegate : RatingViewDelegate?
    
    enum RatingMode : Int {
        case showing = 1
        case selecting = 2
    }

    var ratingMode : RatingMode = .showing {
        didSet {
            switch ratingMode {
            case .showing:
                isUserInteractionEnabled = false
            case .selecting:
                isUserInteractionEnabled = true
            }
        }
    }
    
    @IBOutlet fileprivate weak var star1: ColoredImageView!
    @IBOutlet fileprivate weak var star2: ColoredImageView!
    @IBOutlet fileprivate weak var star3: ColoredImageView!
    @IBOutlet fileprivate weak var star4: ColoredImageView!
    @IBOutlet fileprivate weak var star5: ColoredImageView!
    
    @IBOutlet fileprivate weak var starEmpty1: ColoredImageView!
    @IBOutlet fileprivate weak var starEmpty2: ColoredImageView!
    @IBOutlet fileprivate weak var starEmpty3: ColoredImageView!
    @IBOutlet fileprivate weak var starEmpty4: ColoredImageView!
    @IBOutlet fileprivate weak var starEmpty5: ColoredImageView!
    
    fileprivate var starArray : Array<ColoredImageView> = []
    fileprivate var starEmptyArray : Array<ColoredImageView> = []
    
    override func configureViews() {
        starArray = [star1, star2, star3, star4, star5]
        starEmptyArray = [starEmpty1, starEmpty2, starEmpty3, starEmpty4, starEmpty5]
        paintStars()
        paintEmptyStars()
    }
    
    var ratingValue : Int = 0 {
        didSet {
            ratingDelegate?.ratingHasChanged(value: ratingValue)
            showRating(value: CGFloat(ratingValue))
        }
    }
    
    func showRating(value: CGFloat) {
        
        resetStars()
        
        let valuerRounded = Int(value)
        let remaining = value - CGFloat(valuerRounded)
        var starFullyHidden = starArray.count - valuerRounded
        if remaining > 0 {
            let star = starArray[starArray.count - starFullyHidden]
            star.frame = CGRect(x: star.frame.origin.x, y: star.frame.origin.y, width: star.frame.size.width * remaining, height: star.frame.size.height)
            starFullyHidden -= 1
        }
        
        for (index, star) in starArray.enumerated().reversed() {
            if index >= starArray.count - starFullyHidden   {
                star.isHidden = true
            }
        }
    }
    
    func resetStars() {
        for star in starArray {
            star.isHidden = false
            if let defaultBounds = star.superview?.bounds {
                star.frame = defaultBounds
            }
        }
    }
    
    fileprivate func paintStars() {
        starArray.forEach { (imageView) in
            imageView.imageColor = starDefaultColor
        }
    }
    
    fileprivate func paintEmptyStars() {
        starEmptyArray.forEach { (imageView) in
            imageView.imageColor = starEmptyColor
        }
    }
    
    // superclass methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            convertTouchToRate(point: location)
        }
    }
    
    func convertTouchToRate(point: CGPoint) {
        guard point.x > 0 else {
            return
        }
        
        let starWidth = frame.size.width / CGFloat(starArray.count)
        let ratingFloat = point.x / starWidth
        let ratingInt = Int(ratingFloat)
        
        if ratingFloat < 0.3 {
            if ratingValue != minimumRequiredStar {
                ratingValue = minimumRequiredStar
            }
        } else {
            if ratingValue != ratingInt + 1 {
                ratingValue = ratingInt + 1
            }
        }
    }

}
