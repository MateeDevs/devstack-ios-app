//
//  ImagePickerViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

public protocol ImagePickerControllerDelegate: class {
    func photoSelected(image: UIImage?, sender: UIButton?)
}

open class ImagePickerViewController: BaseViewController {
    
    // MARK: Stored properties
	public var imagePickerTitle: String = L10n.image_picker_title
    public var imagePickerSubtitle: String = L10n.image_picker_subtitle
    private var sender: UIButton? = nil
    
    public weak var imagePickerDelegate: ImagePickerControllerDelegate?
    
    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Additional methods
    @IBAction public func addPicture(_ sender: UIButton) {
        self.sender = sender
        view.endEditing(true)
        
        // Setup action sheet with camera/library options
        let actionSheetController = UIAlertController(title: imagePickerTitle, message: imagePickerSubtitle, preferredStyle: .actionSheet)
        
		let photoLibrary = UIAlertAction(title: L10n.image_picker_library, style: .default, handler: { [weak self] _ in
            self?.selectPhoto(sourceType: .photoLibrary)
        })
        actionSheetController.addAction(photoLibrary)
        
		let takePhotoByCamera = UIAlertAction(title: L10n.image_picker_camera, style: .default, handler: { [weak self] _ in
            self?.selectPhoto(sourceType: .camera)
        })
        actionSheetController.addAction(takePhotoByCamera)
        
		let cancel = UIAlertAction(title: L10n.image_picker_cancel, style: .cancel, handler: nil)
        actionSheetController.addAction(cancel)
        
        // Required for iPad
        actionSheetController.popoverPresentationController?.sourceView = view
        actionSheetController.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        actionSheetController.popoverPresentationController?.permittedArrowDirections = []
        
        present(actionSheetController, animated: true, completion: nil)
    }
    
    private func selectPhoto(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    open func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        // Save image to photo library if taken by camera
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        }
        
        imagePickerDelegate?.photoSelected(image: selectedImage, sender: sender)
        dismiss(animated: true, completion: nil)
    }
}
