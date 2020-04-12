//
//  StartVC.swift
//  SimpleRegistration
//
//  Created by Vladimir Ereskin on 4/12/20.
//  Copyright © 2020 Vladimir Ereskin. All rights reserved.
//

import UIKit
import Firebase

final class StartVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logoutUser))
        title = "Start"
    }
    
    @objc private func logoutUser() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginVC()
            loginVC.modalPresentationStyle = .fullScreen
            
            self.present(loginVC, animated: true, completion: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
}

