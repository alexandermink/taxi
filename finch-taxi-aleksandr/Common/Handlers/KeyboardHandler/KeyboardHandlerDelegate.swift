//
//  KeyboardHandlerDelegate.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 15.02.2022.
//

import CoreGraphics

protocol KeyboardHandlerDelegate: AnyObject {
    func keyboardWillShow(frame: CGRect)
    func keyboardWillHide()
}
