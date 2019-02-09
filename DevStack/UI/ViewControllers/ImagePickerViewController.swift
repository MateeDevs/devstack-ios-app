//
//  ImagePickerViewController.swift
//  Shipvio3
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Qest. All rights reserved.
//

import UIKit

protocol ImagePickerControllerDelegate: class {
    func photoSelected(image: UIImage?, desc: String?)
}

class ImagePickerViewController: InputViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var desc: String?
    
    var image : UIImage? {
        didSet {
            imagePickerDelegate?.photoSelected(image: image, desc: desc)
        }
    }
    
    var imagePickerTitle: String = L10n.imagePickerTitle
    var imagePickerMessage: String = L10n.imagePickerSubtitle
    
    weak var imagePickerDelegate : ImagePickerControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addPicture(_ sender: UIButton) {
        view.endEditing(true)
        
        desc = "\(sender.tag)"
        
        // present ActionSheet with camera/library options
        let actionSheetController = UIAlertController(title: imagePickerTitle, message: imagePickerMessage, preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: L10n.imagePickerLibrary, style: .default, handler: { [weak self] (action) in
            self?.selectPhoto(sourceType: .photoLibrary)
        })
        actionSheetController.addAction(photoLibrary)
        
        let takePhotoByCamera = UIAlertAction(title: L10n.imagePickerCamera, style: .default, handler: { [weak self] (action) in
            self?.selectPhoto(sourceType: .camera)
        })
        actionSheetController.addAction(takePhotoByCamera)
        
        let cancel = UIAlertAction(title: L10n.imagePickerCancel, style: .cancel, handler: nil)
        actionSheetController.addAction(cancel)
        
        // required for iPad
        actionSheetController.popoverPresentationController?.sourceView = self.view
        actionSheetController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        actionSheetController.popoverPresentationController?.permittedArrowDirections = []
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    func selectPhoto(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = sourceType
            present(imagePicker, animated: true, completion: { [weak self] () -> Void in
                self?.view.stopActivityIndicator()
            })
        } else {
            view.stopActivityIndicator()
        }
    }
    
    // MARK: - Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // save image to photo library if taken by camera
            if picker.sourceType == .camera {
                UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
            }
            image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
}
