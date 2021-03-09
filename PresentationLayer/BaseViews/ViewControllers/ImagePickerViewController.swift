//
//  Created by Petr Chmelar on 08/10/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

@objc public protocol ImagePickerViewControllerDelegate: class {
    @objc optional func photoSelected(image: UIImage?)
}

open class ImagePickerViewController: InputViewController {

    // MARK: Stored properties
    public var imagePickerTitle: String = L10n.image_picker_title
    public var imagePickerSubtitle: String = L10n.image_picker_subtitle

    public weak var delegate: ImagePickerViewControllerDelegate?

    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Additional methods
    // swiftlint:disable:next private_action
    @IBAction public func addPicture(_ sender: UIButton) {
        view.endEditing(true)

        // Setup action sheet with camera/library options
        let actionSheetController = UIAlertController(title: imagePickerTitle, message: imagePickerSubtitle, preferredStyle: .actionSheet)

        let photoLibrary = UIAlertAction(title: L10n.image_picker_library, style: .default, handler: { _ in
            self.selectPhoto(sourceType: .photoLibrary)
        })
        actionSheetController.addAction(photoLibrary)

        let takePhotoByCamera = UIAlertAction(title: L10n.image_picker_camera, style: .default, handler: { _ in
            self.selectPhoto(sourceType: .camera)
        })
        actionSheetController.addAction(takePhotoByCamera)

        let cancel = UIAlertAction(title: L10n.image_picker_cancel, style: .cancel, handler: nil)
        actionSheetController.addAction(cancel)

        // Required for iPad
        actionSheetController.popoverPresentationController?.sourceView = view
        let sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
        actionSheetController.popoverPresentationController?.sourceRect = sourceRect
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
    open func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        // Save image to photo library if taken by camera
        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil)
        }

        delegate?.photoSelected?(image: selectedImage)
        dismiss(animated: true, completion: nil)
    }
}