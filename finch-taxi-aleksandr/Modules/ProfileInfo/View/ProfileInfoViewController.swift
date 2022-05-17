//
//  ProfileInfoViewController.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 27.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileInfoViewInput: Alertable {
    func updateUserInfo(userInfo: UserInfo)
    func updateAvatarImage(info: (image: UIImage, name: String)?)
    func updateUIState(isEnabled: Bool)
}

final class ProfileInfoViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let avatarImageViewHeight: CGFloat = 150
        static let deleteImageViewHeight: CGFloat = 28
        static let navBarLeftButtonSize: Int = {
            if #available(iOS 14, *) {
                return 28
            } else {
                return 18
            }
        }()
        
        static let navBarRightButtonSize = 28
    }
    
    
    // MARK: - Properties
    
    var presenter: ProfileInfoViewOutput?
    var keyboardHandler: KeyboardHandler?
    
    private lazy var imagePickerController: UIImagePickerController = {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        return controller
    }()
    
    private var imageInfo: (image: UIImage, name: String)?
    private var scrollViewBottomConstraint = NSLayoutConstraint()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var avatarLoaderImageView = LoaderImageView()
    private let deleteImageButton = UIButton()
    private let phoneNumberLabel = UILabel()
    private let surnameUnderlineTextView = UnderlineTextView(model: .init(
        placeholder: Texts.surname,
        font: Fonts.system18
    ))
    
    private let nameUnderlineTextView = UnderlineTextView(model: .init(
        placeholder: Texts.name,
        font: Fonts.system18
    ))
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawning
    
    private func drawSelf() {
        
        setupNavigation()
        
        view.backgroundColor = Colors.whiteBlack
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
    
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentView.frame.height)
        
        let tapAround = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapAround)

        nameUnderlineTextView.delegate = self
        surnameUnderlineTextView.delegate = self
        
        avatarLoaderImageView = .init(
            model: .init(
                imageViewHeight: Locals.avatarImageViewHeight,
                clipsToBounds: true,
                cornerRadius: Locals.avatarImageViewHeight / 2,
                borderWidth: 3,
                borderColor: Colors.darkGray.cgColor,
                targets: [
                    (target: self, action: #selector(didTapAvatarImage))
                ]
            )
        )
        
        deleteImageButton.clipsToBounds = true
        deleteImageButton.alpha = 0
        deleteImageButton.backgroundColor = Colors.white
        deleteImageButton.tintColor = Colors.red
        deleteImageButton.layer.cornerRadius = Locals.deleteImageViewHeight / 2
        deleteImageButton.layer.borderWidth = 2
        deleteImageButton.contentVerticalAlignment = .fill
        deleteImageButton.contentHorizontalAlignment = .fill
        deleteImageButton.setImage(Images.System.xMarkCircleFill, for: .normal)
        deleteImageButton.addTarget(self, action: #selector(didTapDeleteImageView), for: .touchUpInside)
        
        phoneNumberLabel.textAlignment = .center
        
        [avatarLoaderImageView,
         deleteImageButton,
         surnameUnderlineTextView,
         nameUnderlineTextView,
         phoneNumberLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        scrollViewBottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        scrollViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            avatarLoaderImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 64),
            avatarLoaderImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarLoaderImageView.heightAnchor.constraint(equalToConstant: Locals.avatarImageViewHeight),
            avatarLoaderImageView.widthAnchor.constraint(equalTo: avatarLoaderImageView.heightAnchor),
            
            deleteImageButton.topAnchor.constraint(equalTo: avatarLoaderImageView.topAnchor, constant: 10),
            deleteImageButton.trailingAnchor.constraint(equalTo: avatarLoaderImageView.trailingAnchor, constant: -10),
            deleteImageButton.heightAnchor.constraint(equalToConstant: Locals.deleteImageViewHeight),
            deleteImageButton.widthAnchor.constraint(equalTo: deleteImageButton.heightAnchor),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: avatarLoaderImageView.bottomAnchor, constant: 16),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            surnameUnderlineTextView.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 64),
            surnameUnderlineTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            surnameUnderlineTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            surnameUnderlineTextView.heightAnchor.constraint(equalToConstant: 50),
            
            nameUnderlineTextView.topAnchor.constraint(
                equalTo: surnameUnderlineTextView.bottomAnchor,
                constant: 32
            ),
            nameUnderlineTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameUnderlineTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameUnderlineTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            nameUnderlineTextView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavigation() {
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.customizeStandardAppearance(
            with: .init(tintColor: Colors.darkGray)
        )
        
        navigationItem.leftBarButtonItem = createNavigationBarItem(
            image: Images.backwardArrow,
            action: #selector(didTapCancelButton),
            size: Locals.navBarLeftButtonSize
        )
        
        navigationItem.rightBarButtonItem = createNavigationBarItem(
            image: Images.System.checkmarkCircle,
            action: #selector(didTapSaveButton),
            size: Locals.navBarRightButtonSize
        )
    }
    
    
    // MARK: - Private methods
    
    private func updateScrollViewBottomConstraint(keyboardHeight: CGFloat? = nil) {
        
        let isActive = keyboardHeight != nil
        let keyboardHeight = keyboardHeight ?? 0
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.scrollViewBottomConstraint.constant = isActive ? -(keyboardHeight) : 0
            self.view.superview?.layoutIfNeeded()
        }
    }
    
    private func createNavigationBarItem(image: UIImage, action: Selector, size: Int) -> UIBarButtonItem {
        
        let button = UIButton(frame: .init(x: 0, y: 0, width: size, height: size))
        
        button.setImage(image, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return .init(customView: button)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapAvatarImage(_ touch: UITouch) {
        
        if avatarLoaderImageView.isTapAreaContains(touch) {
            avatarLoaderImageView.startAnimating()
            present(imagePickerController, animated: true) {
                self.avatarLoaderImageView.stopAnimating()
            }
        } else {
            dismissKeyboard()
        }
    }
    
    @objc
    private func didTapDeleteImageView() {
        updateAvatarImage(info: nil)
    }
    
    @objc
    private func didTapCancelButton() {
        presenter?.didTapCancelButton()
    }
    
    @objc
    private func didTapSaveButton() {
        
        presenter?.didTapSaveButton(
            surname: surnameUnderlineTextView.textFieldValue,
            name: nameUnderlineTextView.textFieldValue,
            imageInfo: imageInfo
        )
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


// MARK: - MyInfoViewInput
extension ProfileInfoViewController: ProfileInfoViewInput {
    
    func updateUserInfo(userInfo: UserInfo) {
        
        surnameUnderlineTextView.textFieldValue = userInfo.surname ?? ""
        nameUnderlineTextView.textFieldValue = userInfo.name ?? ""
        phoneNumberLabel.text = userInfo.phoneNumber
    }
    
    func updateAvatarImage(info: (image: UIImage, name: String)?) {
        
        avatarLoaderImageView.startAnimating()
        avatarLoaderImageView.image = info?.image ?? Images.System.personCropCircle
        self.imageInfo = info
        UIView.animate(withDuration: 1) {
            self.deleteImageButton.alpha = info != nil ? 1 : 0
        } completion: { _ in
            self.avatarLoaderImageView.stopAnimating()
        }
    }
    
    func updateUIState(isEnabled: Bool) {
        
        let alpha = isEnabled ? 1 : 0.5
        UIView.animate(withDuration: 1) {
            self.contentView.alpha = alpha
            self.tabBarController?.tabBar.alpha = alpha
        }
        
        navigationItem.leftBarButtonItem?.isEnabled = isEnabled
        tabBarController?.tabBar.isUserInteractionEnabled = isEnabled
        contentView.isUserInteractionEnabled = isEnabled
        
        let saveButtonLoader = UIActivityIndicatorView()
        isEnabled ? saveButtonLoader.stopAnimating() : saveButtonLoader.startAnimating()
        navigationItem.rightBarButtonItem?.customView = saveButtonLoader
    }
}


// MARK: - KeyboardHandlerDelegate
extension ProfileInfoViewController: KeyboardHandlerDelegate {
    
    func keyboardWillShow(frame: CGRect) {
        updateScrollViewBottomConstraint(keyboardHeight: frame.height)
    }
    
    func keyboardWillHide() {
        updateScrollViewBottomConstraint()
    }
    
}


// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        avatarLoaderImageView.startAnimating()
        dismiss(animated: true) {
            guard let image = info[.originalImage] as? UIImage,
                  let name = (info[.imageURL] as? URL)?.lastPathComponent
            else {
                return
            }
            self.updateAvatarImage(info: (image: image, name: name))
        }
    }
}


// MARK: - UnderlineTextViewOutput
extension ProfileInfoViewController: UnderlineTextViewOutput {
    
    func underlineTextViewBeginEditing(_ view: UnderlineTextView) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let distance = view.frame.origin.y + view.frame.height + 8
            if distance > self.scrollView.frame.height {
                self.scrollView.setContentOffset(
                    CGPoint(x: 0, y: distance - self.scrollView.frame.height),
                    animated: true
                )
            }
        }
    }
    
}
