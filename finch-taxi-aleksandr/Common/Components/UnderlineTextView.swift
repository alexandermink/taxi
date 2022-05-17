//
//  UnderlineTextView.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 04.02.2022.
//

import UIKit

protocol UnderlineTextViewOutput: AnyObject {
    func underlineTextViewBeginEditing(_ view: UnderlineTextView)
}

final class UnderlineTextView: NLView {
    
    // MARK: - Types
    
    typealias Target = UIControl.Target
    typealias Colors = Constants.Colors
    typealias Fonts = Constants.Fonts
    
    
    // MARK: - Properties
    
    weak var delegate: UnderlineTextViewOutput?
    
    var textFieldValue: String {
        
        set {
            textField.text = newValue
        }
        get {
            textField.text ?? ""
        }
    }
    
    private let textField = UITextField()
    private let line = UIView()
    
    
    // MARK: - Init
    
    init(model: Model = Model()) {
        super.init(frame: .zero)
        
        drawSelf()
        configure(with: model)
    }
    
    
    // MARK: - NLView
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        return textField.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        return textField.resignFirstResponder()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        addSubview(textField)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        addSubview(line)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.topAnchor.constraint(equalTo: textField.bottomAnchor),
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func addTextFieldTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    private func addTextFieldTargets(_ targets: [Target]) {
        targets.forEach {
            addTextFieldTarget($0.target, action: $0.action, for: $0.event)
        }
    }
    
}


// MARK: - Configurable
extension UnderlineTextView: Configurable {
    
    func configure(with model: Model) {
        
        textField.placeholder = model.placeholder
        textField.textAlignment = model.textAlignment
        textField.font = model.font
        textField.textColor = model.textColor
        textField.tintColor = model.tintColor
        textField.keyboardType = model.keyboardType
        
        if let targets = model.targets, !targets.isEmpty {
            addTextFieldTargets(targets)
        }
        
        line.backgroundColor = model.lineColor
    }
}


// MARK: - Model
extension UnderlineTextView {
    
    struct Model {
        
        // MARK: - Properties
        
        let placeholder: String
        let textAlignment: NSTextAlignment
        let font: UIFont
        let textColor: UIColor
        let tintColor: UIColor
        let keyboardType: UIKeyboardType
        let lineColor: UIColor
        let targets: [Target]?
        
        
        // MARK: - Init
        
        init(placeholder: String = "",
             textAlignment: NSTextAlignment = .center,
             font: UIFont = Fonts.system12,
             textColor: UIColor = Colors.blackWhite,
             tintColor: UIColor = Colors.lightGray,
             keyboardType: UIKeyboardType = .default,
             lineColor: UIColor = Colors.lightGray,
             targets: [Target]? = nil) {
            
            self.placeholder = placeholder
            self.textAlignment = textAlignment
            self.font = font
            self.textColor = textColor
            self.tintColor = tintColor
            self.keyboardType = keyboardType
            self.lineColor = lineColor
            self.targets = targets
        }
        
    }
}


// MARK: - UITextFieldDelegate
extension UnderlineTextView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.underlineTextViewBeginEditing(self)
    }
    
}
