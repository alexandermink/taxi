//
//  LoaderImageView.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 21.04.2022.
//

import UIKit

class LoaderImageView: NLView {
    
    // MARK: - Types
    
    typealias Target = UIControl.TapTarget
    
    
    // MARK: - Properties
    
    var image: UIImage? {
        set {
            imageView.image = newValue
        }
        get {
            imageView.image
        }
    }
    
    private var imageViewHeight: CGFloat = 0
    private let imageView = UIImageView()
    private let indicator = UIActivityIndicatorView()
    
    
    // MARK: - Init
    
    init(model: Model = Model()) {
        super.init(frame: .zero)
        
        drawSelf()
        configure(with: model)
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            indicator.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            indicator.widthAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
    
    
    // MARK: - Public methods
    
    func startAnimating() {
        indicator.startAnimating()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
    }
    
    func isTapAreaContains(_ touch: UITouch) -> Bool{
        UIBezierPath(
            roundedRect: imageView.bounds,
            cornerRadius: imageView.layer.cornerRadius
        ).contains(touch.location(in: imageView))
    }
    
    
    // MARK: - Private methods
    
    private func addImageViewTarget(_ target: Any?, action: Selector) {
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
    }
    
    private func addImageViewTargets(_ targets: [Target]) {
        targets.forEach {
            addImageViewTarget($0.target, action: $0.action)
        }
    }
}


// MARK: - Configurable
extension LoaderImageView: Configurable {
    
    func configure(with model: Model) {
        
        imageView.image = model.image
        imageViewHeight = model.imageViewHeight
        imageView.clipsToBounds = model.clipsToBounds
        imageView.tintColor = model.tintColor
        imageView.layer.cornerRadius = model.cornerRadius
        imageView.layer.borderWidth = model.borderWidth
        
        if let borderColor = model.borderColor {
            imageView.layer.borderColor = borderColor
        }
        
        if let targets = model.targets, !targets.isEmpty {
            addImageViewTargets(targets)
        }
        
        indicator.style = model.style
        indicator.backgroundColor = model.indicatorBackgroundColor
    }
}


// MARK: - Model
extension LoaderImageView {
    
    struct Model {
        
        // MARK: - Properties
        
        let image: UIImage?
        let imageViewHeight: CGFloat
        let clipsToBounds: Bool
        let tintColor: UIColor
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let borderColor: CGColor?
        let targets: [Target]?
        
        let style: UIActivityIndicatorView.Style
        let indicatorBackgroundColor: UIColor
        
        
        // MARK: - Init
        
        init(image: UIImage? = Images.System.personCropCircle,
             imageViewHeight: CGFloat = 100,
             clipsToBounds: Bool = false,
             tintColor: UIColor = Colors.darkGray,
             cornerRadius: CGFloat = 0,
             borderWidth: CGFloat = 0,
             borderColor: CGColor? = nil,
             targets: [Target]? = nil,
             
             style: UIActivityIndicatorView.Style = .large,
             indicatorBackgroundColor: UIColor = Colors.customLightGray.withAlphaComponent(0.8)) {
            
            self.image = image
            self.imageViewHeight = imageViewHeight
            self.clipsToBounds = clipsToBounds
            self.tintColor = tintColor
            self.cornerRadius = cornerRadius
            self.borderWidth = borderWidth
            self.borderColor = borderColor
            self.targets = targets
            
            self.style = style
            self.indicatorBackgroundColor = indicatorBackgroundColor
        }
    }
}
