//
//  UIView+Extension.swift
//  SimpleRegistration
//
//  Created by Vladimir Ereskin on 4/12/20.
//  Copyright © 2020 Vladimir Ereskin. All rights reserved.
//

import UIKit

extension UIView {
    
    var topSuperview: UIView? {
        var view = superview
        while view?.superview != nil {
            view = view!.superview
        }
        return view
    }
    
    /// Installing constraints on all sides
    func pinToSuperview() {
        guard let superview = self.superview else { return }
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    /// Adding a views  to the current view
    /// - Parameter view: Views
    func addSubviews(_ view: UIView...) {
        for view in view {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
    }
    
    /// keyboard hide gesture
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        topSuperview?.endEditing(true)
    }
}
