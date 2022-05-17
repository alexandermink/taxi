//
//  VerificationViewController.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 04.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol VerificationViewInput: Alertable {
    func updateInterface(phoneNumber: String)
    func changeKeyboardState(isActive: Bool)
    func startEnterSMSCode()
    func updateUIState(isEnabled: Bool)
}

final class VerificationViewController: UIViewController {
    
    // MARK: - Locals
    
    private enum Locals {
        static let contentBottomIndent: CGFloat = DeviceType.isSmall ? -100 : -203
    }
    
    
    // MARK: - Properties
    
    var presenter: VerificationViewOutput?
    var keyboardHandler: KeyboardHandler?
    
    private var smsCodeUnderlineTextViewBottomConstraint = NSLayoutConstraint()
    
    private let subtitleLabel = UILabel()
    private let smsCodeUnderlineTextView = UnderlineTextView()
    private let resendSMSCodeButton = UIButton()
    private let contentView = UIView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
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
        titleLabel.text = Texts.enterCode
        titleLabel.font = Fonts.systemBold40
        titleLabel.textColor = Colors.blackWhite
        contentView.addSubview(titleLabel)
        
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = Fonts.system16
        subtitleLabel.textColor = Colors.blackWhite
        contentView.addSubview(subtitleLabel)
        
        let smsCodeComponentsContainer = UIView()
        contentView.addSubview(smsCodeComponentsContainer)
        
        smsCodeUnderlineTextView.configure(
            with: UnderlineTextView.Model(
                placeholder: Texts.smsCode,
                textAlignment: .left,
                font: Fonts.system16,
                keyboardType: .numberPad,
                targets: [
                    (target: self,
                     action: #selector(didInputSMSCodeTextField),
                     event: .editingChanged)
                ]
            )
        )
        smsCodeComponentsContainer.addSubview(smsCodeUnderlineTextView)
        
        resendSMSCodeButton.backgroundColor = Colors.clear
        resendSMSCodeButton.setTitle(Texts.resend, for: .normal)
        resendSMSCodeButton.titleLabel?.font = Fonts.system14
        resendSMSCodeButton.setTitleColor(Colors.black, for: .normal)
        resendSMSCodeButton.addTarget(self, action: #selector(didTapResendSMSCodeButton), for: .touchUpInside)
        smsCodeComponentsContainer.addSubview(resendSMSCodeButton)
        
        let changePhoneNumberButton = UIButton()
        changePhoneNumberButton.backgroundColor = Colors.clear
        changePhoneNumberButton.setTitle(Texts.anotherNumber, for: .normal)
        changePhoneNumberButton.titleLabel?.font = Fonts.system16
        changePhoneNumberButton.setTitleColor(Colors.darkGray, for: .normal)
        changePhoneNumberButton.addTarget(
            self,
            action: #selector(didTapChangePhoneNumberButton),
            for: .touchUpInside
        )
        smsCodeComponentsContainer.addSubview(changePhoneNumberButton)
        
        activityIndicator.alpha = 0
        
        [
            contentView,
            titleLabel,
            subtitleLabel,
            smsCodeComponentsContainer,
            smsCodeUnderlineTextView,
            resendSMSCodeButton,
            changePhoneNumberButton,
            activityIndicator
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(contentView)
        view.addSubview(activityIndicator)
        
        smsCodeUnderlineTextViewBottomConstraint = smsCodeComponentsContainer.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: Locals.contentBottomIndent
        )
        smsCodeUnderlineTextViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: DeviceType.isSmall ? 32 : 96
            ),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleLabel.heightAnchor.constraint(equalToConstant: 38),
            
            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: DeviceType.isSmall ? 16 : 32
            ),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            
            smsCodeComponentsContainer.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            smsCodeComponentsContainer.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 32
            ),
            smsCodeComponentsContainer.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -32
            ),
            
            smsCodeUnderlineTextView.centerYAnchor.constraint(
                equalTo: smsCodeComponentsContainer.centerYAnchor,
                constant: DeviceType.isSmall ? -30 : -60
            ),
            smsCodeUnderlineTextView.leadingAnchor.constraint(
                equalTo: smsCodeComponentsContainer.leadingAnchor
            ),
            smsCodeUnderlineTextView.trailingAnchor.constraint(
                equalTo: smsCodeComponentsContainer.trailingAnchor
            ),
            smsCodeUnderlineTextView.heightAnchor.constraint(equalToConstant: 50),
            
            resendSMSCodeButton.topAnchor.constraint(
                equalTo: smsCodeUnderlineTextView.bottomAnchor,
                constant: DeviceType.isSmall ? 16 : 32
            ),
            resendSMSCodeButton.trailingAnchor.constraint(
                equalTo: smsCodeComponentsContainer.trailingAnchor
            ),
            
            changePhoneNumberButton.centerXAnchor.constraint(
                equalTo: smsCodeComponentsContainer.centerXAnchor
            ),
            changePhoneNumberButton.bottomAnchor.constraint(equalTo: smsCodeComponentsContainer.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    // MARK: - Private methods
    
    private func updateSMSCodeUnderlineTextViewBottomConstraint(keyboardHeight: CGFloat? = nil) {
        
        let isActive = keyboardHeight != nil
        let keyboardHeight = keyboardHeight ?? 0
        
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            self.smsCodeUnderlineTextViewBottomConstraint.constant = isActive ? -(keyboardHeight + (DeviceType.isSmall ? 8 : 16)) : Locals.contentBottomIndent
            self.view.superview?.layoutIfNeeded()
        }
        
    }
    
    private func startResendSMSCodeTimer() {
        
        var seconds = 60
        
        resendSMSCodeButton.setTitle(
            Texts.resendCodeTimerTemplate.replacingOccurrences(of: "#", with: String(seconds)),
            for: .disabled
        )
        resendSMSCodeButton.isEnabled = false

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            if seconds == 1 {
                self.resendSMSCodeButton.isEnabled = true
                timer.invalidate()
            } else {
                self.resendSMSCodeButton.setTitle(
                    Texts.resendCodeTimerTemplate.replacingOccurrences(of: "#", with: String(seconds-1)),
                    for: .disabled
                )
            }
            seconds -= 1
        }
    }
    
    
    // MARK: - Actions
    
    @objc
    private func didTapResendSMSCodeButton() {
        startResendSMSCodeTimer()
    }
    
    @objc
    private func didTapChangePhoneNumberButton() {
        presenter?.didTapChangePhoneNumber()
    }
    
    @objc
    private func didInputSMSCodeTextField() {
        
        guard smsCodeUnderlineTextView.textFieldValue.count == 4 else {
            return
        }
        
        changeKeyboardState(isActive: false)
        presenter?.didEnterSMSCode(smsCodeUnderlineTextView.textFieldValue)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


// MARK: - VerificationViewInput
extension VerificationViewController: VerificationViewInput {
    
    func changeKeyboardState(isActive: Bool) {
        let _ = isActive ? smsCodeUnderlineTextView.becomeFirstResponder() :
        smsCodeUnderlineTextView.resignFirstResponder()
    }
    
    func updateInterface(phoneNumber: String) {
        subtitleLabel.text = Texts.enterSMSCodeTemplate.replacingOccurrences(of: "#", with: phoneNumber)
        startResendSMSCodeTimer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.startEnterSMSCode()
        }
    }
    
    func startEnterSMSCode() {
        smsCodeUnderlineTextView.textFieldValue = ""
        changeKeyboardState(isActive: true)
    }
    
    func updateUIState(isEnabled: Bool) {
        
        UIView.animate(withDuration: 1) {
            self.contentView.alpha = isEnabled ? 1 : 0.3
            self.activityIndicator.alpha = isEnabled ? 0 : 1
        }
        
        view.isUserInteractionEnabled = isEnabled
        isEnabled ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
    }
}


// MARK: - KeyboardHandlerDelegate
extension VerificationViewController: KeyboardHandlerDelegate {
    
    func keyboardWillShow(frame: CGRect) {
        updateSMSCodeUnderlineTextViewBottomConstraint(keyboardHeight: frame.height)
    }
    
    func keyboardWillHide() {
        updateSMSCodeUnderlineTextViewBottomConstraint()
    }
    
}
