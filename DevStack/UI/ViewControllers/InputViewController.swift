//
//  InputViewController.swift
//  DevStack
//
//  Created by Petr Chmelar on 09/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import UIKit

open class InputViewController: BaseViewController {

    // MARK: UI components
    @IBOutlet public weak var scrollView: UIScrollView?

    // MARK: Lifecycle methods
    override open func viewDidLoad() {
        super.viewDidLoad()

        if let scrollView = scrollView {
            scrollView.keyboardDismissMode = .interactive
        }
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Additional methods
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let scrollView = scrollView,
            let userInfo = notification.userInfo,
            var keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 50
        scrollView.contentInset = contentInset
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = scrollView else { return }
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}

extension InputViewController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension InputViewController: UITextViewDelegate {
    open func textViewDidBeginEditing(_ textView: UITextView) {
        if let localizedTextView = textView as? LocalizedTextView {
            if textView.text == localizedTextView.placeholder {
                textView.text = ""
                textView.textColor = localizedTextView.defaultColor
            }
        }
    }

    open func textViewDidEndEditing(_ textView: UITextView) {
        if let localizedTextView = textView as? LocalizedTextView {
            if textView.text == "" {
                textView.text = localizedTextView.placeholder
                textView.textColor = localizedTextView.placeholderColor
            }
        }
    }
}
