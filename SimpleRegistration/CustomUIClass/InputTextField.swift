//
//  InputTextField.swift
//  SimpleRegistration
//
//  Created by Vladimir Ereskin on 4/12/20.
//  Copyright © 2020 Vladimir Ereskin. All rights reserved.
//

import UIKit

/// Custom class TextField for auth/register
final class InputTextField: UITextField {
    init(text: String, image: UIImage?, isSecureText: Bool) {
        super.init(frame: .zero)
        
        if let image = image {
            setLeftView(image: image)
        }
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        isSecureTextEntry = isSecureText
        textColor = .black
        placeholder = text
        background = UIImage(contentsOfFile: "")
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        textAlignment = .left
        borderStyle = .none
        returnKeyType = .continue
        autocorrectionType = .no
        autocapitalizationType = .none
        smartInsertDeleteType = .no
        spellCheckingType = .no
        font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
