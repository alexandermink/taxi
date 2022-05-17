//
//  LoginViewController.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 03.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol LoginViewInput: Alertable {
    func changeKeyboardState(isActive: Bool)
    func updateInterface()
}

final class LoginViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let contentBottomIndent: CGFloat = DeviceType.isSmall ? -100 : -203
    }
    
    
    // MARK: - Properties
    
    var presenter: LoginViewOutput?
    var keyboardHandler: KeyboardHandler?
    
    private var loginButtonBottomConstraint = NSLayoutConstraint()
    
    private let phoneNumberUnderlineTextView = UnderlineTextView()
    private let loginButton = UIButton()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.whiteBlack
        
        let tapAround = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapAround)
        
        let titleLabel = UILabel()
        titleLabel.text = Texts.signIn
        titleLabel.font = Fonts.systemBold40
        titleLabel.textColor = Colors.blackWhite
        view.addSubview(titleLabel)
        
        let phoneNumberUnderlineTextViewContainer = UIView()
        view.addSubview(phoneNumberUnderlineTextViewContainer)
        
        phoneNumberUnderlineTextView.configure(
            with: UnderlineTextView.Model(
                placeholder: Texts.phoneNumber,
                textAlignment: .left,
                font: Fonts.system16,
                keyboardType: .numberPad,
                targets: [
                    (target: self,
                     action: #selector(didChangePhoneNumberTextField),
                     event: .editingChanged)
                ]
            )
        )
        phoneNumberUnderlineTextViewContainer.addSubview(phoneNumberUnderlineTextView)
        
        loginButton.layer.cornerRadius = 21
        loginButton.backgroundColor = Colors.customLightGray
        loginButton.setTitle(Texts.signIn, for: .normal)
        loginButton.setTitleColor(Colors.black, for: .normal)
        loginButton.setTitleColor(Colors.gray, for: .disabled)
        loginButton.titleLabel?.font = Fonts.system16
        loginButton.tintColor = Colors.black
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        view.addSubview(loginButton)
        
        [titleLabel, phoneNumberUnderlineTextViewContainer, phoneNumberUnderlineTextView, loginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        loginButtonBottomConstraint = loginButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: Locals.contentBottomIndent
        )
        loginButtonBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: DeviceType.isSmall ? 32 : 96
            ),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            phoneNumberUnderlineTextViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            phoneNumberUnderlineTextViewContainer.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 32
            ),
            phoneNumberUnderlineTextViewContainer.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -32
            ),
            
            phoneNumberUnderlineTextView.centerYAnchor.constraint(
                equalTo: phoneNumberUnderlineTextViewContainer.centerYAnchor
            ),
            phoneNumberUnderlineTextView.leadingAnchor.constraint(
                equalTo: phoneNumberUnderlineTextViewContainer.leadingAnchor
            ),
            phoneNumberUnderlineTextView.trailingAnchor.constraint(
                equalTo: phoneNumberUnderlineTextViewContainer.trailingAnchor
            ),
            phoneNumberUnderlineTextView.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: phoneNumberUnderlineTextViewContainer.bottomAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 220),
            loginButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func updateLoginButtonBottomConstraint(keyboardHeight: CGFloat? = nil) {
        
        let isActive = keyboardHeight != nil
        let keyboardHeight = keyboardHeight ?? 0
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.loginButtonBottomConstraint.constant = isActive ? -(keyboardHeight + 16) : Locals.contentBottomIndent
            self.view.superview?.layoutIfNeeded()
        }
        
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapLoginButton() {
        presenter?.didTapLoginButton(phoneNumber: phoneNumberUnderlineTextView.textFieldValue)
    }
    
    @objc
    private func didChangePhoneNumberTextField() {
        loginButton.isEnabled = phoneNumberUnderlineTextView.textFieldValue.count >= 18 ? true : false
        phoneNumberUnderlineTextView.textFieldValue = phoneNumberUnderlineTextView.textFieldValue.appliedPhoneNumberMask()
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


// MARK: - LoginViewInput
extension LoginViewController: LoginViewInput {
    
    func changeKeyboardState(isActive: Bool) {
        let _ = isActive ? phoneNumberUnderlineTextView.becomeFirstResponder() :
        phoneNumberUnderlineTextView.resignFirstResponder()
    }
    
    func updateInterface() {
        phoneNumberUnderlineTextView.textFieldValue = ""
        didChangePhoneNumberTextField()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.changeKeyboardState(isActive: true)
        }
    }
    
}


// MARK: - KeyboardHandlerDelegate
extension LoginViewController: KeyboardHandlerDelegate {
    
    func keyboardWillShow(frame: CGRect) {
        updateLoginButtonBottomConstraint(keyboardHeight: frame.height)
    }
    
    func keyboardWillHide() {
        updateLoginButtonBottomConstraint()
    }
    
}
