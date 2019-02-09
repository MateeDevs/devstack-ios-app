//
//  DropDownSelector.swift
//  Shipvio3
//
//  Created by Viktor Kaderabek on 31/08/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

protocol Dismissable: class {
    func dismissProcessing()
}

class DropDownSelector: XIBView, Dismissable {
    
    override var nibName: String {
        get {
            return DropDownSelector.nameOfClass
        }
    }
    
    var changeUserInteractionPreferences: Bool = true
    
    var isSelectionInProgress : Bool = false {
        didSet {
            if isSelectionInProgress {
                bottomConstraint.constant = 0
            } else {
                bottomConstraint.constant = self.bounds.size.height - selectionView.bounds.size.height
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var bottomConstraint : NSLayoutConstraint!
    @IBOutlet weak var selectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var dropDownView: UIView! {
        didSet {
            dropDownView.layer.borderColor = UIColor.lightGray.cgColor
            dropDownView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var dropDownArrow: ColoredImageView!
    @IBOutlet weak var selectedItemLabel: UILabel!
    
    var sourceData : Array<String> = [] {
        didSet {
            selectedItemLabel.text = sourceData.first
            configureViews()
        }
    }
    var indexSelected: Int = 0
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: DropDownSelectorCell.nameOfClass, bundle: nil), forCellReuseIdentifier: DropDownSelectorCell.nameOfClass)
            tableView.superview?.backgroundColor = UIColor.clear
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            selectionView.layer.cornerRadius = cornerRadius
            dropDownView.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var arrowTint: UIColor = UIColor.black {
        didSet {
            dropDownArrow.imageColor = arrowTint
        }
    }
    
    @IBInspectable var labelTextColor: UIColor = UIColor.black {
        didSet {
            selectedItemLabel.textColor = labelTextColor
        }
    }
    
    @IBInspectable var labelFont: UIFont = UIFont.systemFont(ofSize: 17){
        didSet {
            selectedItemLabel.font = labelFont
        }
    }
    
    override func configureViews() {
        super.configureViews()
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.bottomConstraint.constant = strongSelf.bounds.size.height - strongSelf.selectionView.bounds.size.height
        }
//        dropDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
    }
    
    
    // MARK: - Actions
    @objc func makeSelectionOuterConnection() {
        makeSelection()
    }
    @IBAction func makeSelection() {
        makeSelection(index: indexSelected)
    }
    
    func makeSelection(index: Int) {
        isSelectionInProgress = !isSelectionInProgress
        if !isSelectionInProgress {
            selectedItemLabel.text = sourceData[index]
            indexSelected = index
        }
        
        if changeUserInteractionPreferences {
            self.isUserInteractionEnabled = isSelectionInProgress
        }
        
        dropDownList()
    }
    
    func forceSelection(index: Int) {
        selectedItemLabel.text = sourceData[index]
        indexSelected = index
        view.layoutIfNeeded()
    }
    
    fileprivate func dropDownList() {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: { [weak self] in
            self?.view.layoutIfNeeded()
            self?.dropDownArrow.transform = self?.isSelectionInProgress == false ? CGAffineTransform.identity : CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
    }
    
    
    // MARK: - Dismissable delegate
    func dismissProcessing() {
        if isSelectionInProgress {
            isSelectionInProgress = false
            dropDownList()
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

