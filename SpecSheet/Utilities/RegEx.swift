//
//  RegEx.swift
//  FBTime_Terminal
//
//  Created by Kraig Wastlund on 3/13/19.
//  Copyright © 2019 Fishbowl. All rights reserved.
//

import Foundation

//////////////////////////////////////////////////////////////////////////////
// regex explanations
//        ^                         Start anchor
//        (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
//        (?=.*[!@#$&*])            Ensure string has one special case letter.
//        (?=.*[0-9].*[0-9])        Ensure string has two digits.
//        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
//        .{8,}                     Ensure string is at least of length 8.
//        (.*[a-z]+.*)              Ensure at least one lowercase
//        $                         Ending anchor
//////////////////////////////////////////////////////////////////////////////

struct EmailValidation {
    static func isValid(email: String) -> Bool {

        let emailRegularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        return email ~= emailRegularExpression
    }
}

struct UsernameValidation {
    static func isValid(username: String) -> Bool {
        
        if username ~= "^.{1,}$" { // at least 1 characters long
            return true
        }

        return false
    }
}

struct PhoneValidation {
    static func isValid(phone: String) -> Bool {
        
        let PHONE_REGEX = "^\\(\\d{3}\\)\\s\\d{3}-\\d{4}$"     // (333) 333-3333
        
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        
        return phoneTest.evaluate(with: phone)
    }
}

struct PasswordValidation {
    static func isValid(password: String) -> Bool {
        
        if password ~= "^(.*[A-Z]+).*$" { // at least one capital
            if password ~= "^(.*[a-z]+).*$" { // at least one lowercase
                if password ~= "^(.*[0-9]+).*$" { // at least one digit
                    if password ~= "^.{9,}$" { // at least 9 characters long
                        return true
                    }
                }
            }
        }

        return false
    }
}

private extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

private extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}
