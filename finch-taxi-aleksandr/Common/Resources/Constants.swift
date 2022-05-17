//
//  Constants.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 14.02.2022.
//

import UIKit

// MARK: - Types

typealias Fonts = Constants.Fonts
typealias Colors = Constants.Colors
typealias DeviceType = Constants.DeviceType
typealias Images = Constants.Images
typealias Texts = Constants.Texts
typealias SystemKeys = Constants.SystemKeys


// MARK: - Constants

enum Constants {
    
    enum DeviceType {
        static let isSmall = UIScreen.main.bounds.width <= 350
    }
}


// MARK: - Fonts
extension Constants {
    
    enum Fonts {
        static let system12 = UIFont.systemFont(ofSize: 12)
        static let system14 = UIFont.systemFont(ofSize: 14)
        static let system16 = UIFont.systemFont(ofSize: 16)
        static let systemBold16 = UIFont.systemFont(ofSize: 16, weight: .bold)
        static let system18 = UIFont.systemFont(ofSize: 18)
        static let systemMedium18 = UIFont.systemFont(ofSize: 18, weight: .medium)
        static let systemBold40 = UIFont.systemFont(ofSize: 40, weight: .bold)
    }
}


// MARK: - Colors
extension Constants {
    
    enum Colors {
        static let clear = UIColor.clear
        static let white = UIColor.white
        static let black = UIColor.black
        /// White - Light appearance, Black - Dark appearance
        static let whiteBlack = UIColor(named: "White+Black") ?? .white
        /// Black - Light appearance, White - Dark appearance
        static let blackWhite = UIColor(named: "Black+White") ?? .black
        static let gray = UIColor.gray
        static let darkGray = UIColor.darkGray
        static let lightGray = UIColor.lightGray
        static let red = UIColor.red
        static let customLightGray = UIColor(rgb: 0xE9E9E9)
    }
}


// MARK: - Images
extension Constants {
    
    enum Images {
        
        enum System {
            static let personCropCircle = UIImage.getImage(bySystemName: "person.crop.circle")
            static let xMarkCircleFill = UIImage.getImage(bySystemName: "xmark.circle.fill")
            static let checkmarkCircle = UIImage.getImage(bySystemName: "checkmark.circle")
            static let chevronLeft = UIImage.getImage(bySystemName: "chevron.left")
            
            @available(iOS, introduced: 14, message: "Image was added in iOS 14")
            fileprivate static let arrowBackwardCircle = UIImage.getImage(bySystemName: "arrow.backward.circle")
        }
        
        enum MainTabBarIcons {
            static let general = UIImage.getImage(byName: "generalTabBarIcon")
            static let myTravels = UIImage.getImage(byName: "myTravelsTabBarIcon")
            static let profile = UIImage.getImage(byName: "profileTabBarIcon")
        }
        
        static let rightArrow = UIImage.getImage(byName: "rightArrow")
        static let backwardArrow: UIImage = {
            if #available(iOS 14, *) {
                return System.arrowBackwardCircle
            } else {
                return System.chevronLeft
            }
        }()
    }
}


// MARK: - Texts
extension Constants {
    
    enum Texts {
        static let enterSMSCodeTemplate = "Мы отправили СМС с кодом на номер #. Пожалуйста, введите его в поле ниже"
        static let resendCodeTimerTemplate = "Повторно отправить код через: # сек."
        static let smsCode = "Код из SMS"
        static let surname = "Фамилия"
        static let name = "Имя"
        static let phoneNumber = "Телефон"
        static let signIn = "Войти"
        static let enterCode = "Введите код"
        static let resend = "Отправить еще раз"
        static let anotherNumber = "Другой номер"
        static let done = "Готово"
        static let ok = "Ок"
        static let invalidCode = "Код неверный!"
        static let unknownError = "Неизвестная ошибка"
        static let comingSoonTemplate = "Coming soon#"
    }
}


// MARK: - SystemKeys
extension Constants {
    
    enum SystemKeys {
        static let titleTextColor = "titleTextColor"
    }
}
