//
//  UITextField+Extension.swift
//  SimpleRegistration
//
//  Created by Vladimir Ereskin on 4/12/20.
//  Copyright © 2020 Vladimir Ereskin. All rights reserved.
//

import UIKit

extension UITextField {
    func setLeftView(image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 22, y: 10, width: 13, height: 14))
        iconView.image = image
        let iconContainerView = UIView(frame: CGRect(x: 22, y: 0, width: 66, height: 33))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
        self.tintColor = .black
    }
}
