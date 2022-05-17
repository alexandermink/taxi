//
//  KeyboardHandler.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 15.02.2022.
//

import UIKit

final class KeyboardHandler {
    
    // MARK: - Properties
    
    weak var delegate: KeyboardHandlerDelegate?
    
    
    // MARK: - Init
    
    init(delegate: KeyboardHandlerDelegate? = nil) {
        
        self.delegate = delegate
        
        let notifications = [
            UIResponder.keyboardWillShowNotification: #selector(keyboardWillShow),
            UIResponder.keyboardWillHideNotification: #selector(keyboardWillHide)
        ]
        
        notifications.forEach {
            NotificationCenter.default.addObserver(self, selector: $0.value, name: $0.key, object: nil)
        }
    }
    
    
    // MARK: - Private methods
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        delegate?.keyboardWillShow(frame: frame.cgRectValue)
    }
    
    @objc
    private func keyboardWillHide() {
        delegate?.keyboardWillHide()
    }
    
}
