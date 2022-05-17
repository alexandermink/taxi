//
//  String + PhoneNumberMask.swift
//  finch-taxi-aleksandr
//
//  Created by Александр Минк on 04.02.2022.
//

extension String {
    
    /// Маска телефона формата "+7 (###) ###-##-##"
    
    func appliedPhoneNumberMask() -> String {
        
        var numberPattern = " (___) ___-__-__"
        var resultNumber = ""
        let countryCode = "+7"
        let replacementCharacter: Character = "_"
        
        var pureNumber = replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if pureNumber.count > 0 && pureNumber.first == "7" {
            pureNumber.removeFirst()
        }
        
        while !pureNumber.isEmpty {
            
            if resultNumber.count > 15 {
                break
            }
            
            if numberPattern.first != replacementCharacter {
                resultNumber.append(String(numberPattern.removeFirst()))
            } else {
                numberPattern.removeFirst()
                
                if pureNumber.count != 0 {
                    resultNumber.append(pureNumber.removeFirst())
                }
            }
        }
        
        return resultNumber.isEmpty ? resultNumber : countryCode + resultNumber
    }
    
}
