//
//  LoginVC.swift
//  SimpleRegistration
//
//  Created by Vladimir Ereskin on 4/12/20.
//  Copyright © 2020 Vladimir Ereskin. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    private struct Constants {
        static let iconSize: CGFloat = 110
        static let sideMargin: CGFloat = 20
    }
    
    //MARK: - Properties
    
    /// Icon app
    private let icon: UIImageView = {
        let image = UIImageView(image: UIImage(named: ""))
        image.layer.cornerRadius = Constants.iconSize / 2
        image.clipsToBounds = true
        image.layer.borderWidth = 0.5
        return image
    }()
    
    /// Title app
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Simple registration"
        label.textAlignment = .center
        return label
    }()
    
    /// Login input
    private var loginTextField = InputTextField(text: "Email address", image: UIImage(named: "icnEmail"), isSecureText: false)
    
    /// Password input
    private var passTextField = InputTextField(text: "Password", image: UIImage(named: "icnPass"), isSecureText: true)
    
    /// Button register/auth
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(loginTap), for: .touchUpInside)
        return button
    }()
    
    /// label not ID
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Don’t have an ID?"
        return label
    }()
    
    /// Have register button
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    private let stackTextField: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        return stack
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .green
        return indicator
    }()
    
    //MARK: - Life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        makeConstraints()
        addObserving()
    }
    
    //MARK: - User methods
    
    @objc private func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    @objc private func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @objc private func loginTap() {
        guard let login = loginTextField.text, !login.isEmpty else { return }
        guard let password = passTextField.text, !password.isEmpty else { return }
        activityIndicator.startAnimating()
        if loginButton.titleLabel?.text == "Login" {
            Auth.auth().signIn(withEmail: login, password: password) { [weak self] (result, error) in
                self?.activityIndicator.stopAnimating()
                if (error == nil) && (result != nil) {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.showMessage(with: "Email address is badly formatted or password is invalid")
                }
            }
        }
        
        if loginButton.titleLabel?.text == "Register" {
            Auth.auth().createUser(withEmail: loginTextField.text!, password: passTextField.text!) { [weak self] (result, error) in
                self?.activityIndicator.stopAnimating()
                if error == nil {
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.showMessage(with: "User is already registered or password is short")
                }
            }
        }
    }
    
    @objc private func register() {
        if loginButton.titleLabel?.text == "Login" {
            loginButton.setTitle("Register", for: .normal)
            idLabel.text = "Already registered?"
            registerButton.setTitle("Login", for: .normal)
        } else {
            loginButton.setTitle("Login", for: .normal)
            idLabel.text = "Don’t have an ID?"
            registerButton.setTitle("Register", for: .normal)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addTapGestureToHideKeyboard()
        
        view.addSubviews(
            icon,
            titleLabel,
            stackTextField,
            loginButton,
            idLabel,
            registerButton,
            activityIndicator
        )
        
        stackTextField.addArrangedSubview(loginTextField)
        stackTextField.addArrangedSubview(passTextField)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 87),
            icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            icon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            
            titleLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin),
            
            stackTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin),
            stackTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin),
            stackTextField.heightAnchor.constraint(equalToConstant: 122),
            
            loginButton.topAnchor.constraint(equalTo: stackTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            registerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin),
            
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.sideMargin),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.sideMargin),
            idLabel.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -10),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func showMessage(with text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
