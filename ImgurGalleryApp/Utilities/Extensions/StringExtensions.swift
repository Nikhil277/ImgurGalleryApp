//
//  StringExtensions.swift
//
//  Created by Nikhil B Kuriakose on 04/08/20.
//  Copyright © 2020 ArmiaSystems. All rights reserved.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format: "SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
    
    var isValidPhone: Bool {
        let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
        let testPhone = NSPredicate(format: "SELF MATCHES %@", regularExpressionForPhone)
        return testPhone.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegex = "^.{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
