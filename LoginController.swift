//
//  LoginController.swift
//  InstagramFirebase
//
//  Created by asmat manal on 27/11/22.
//  Copyright © 2022 Lets Build That App. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginController: UIViewController{
    
    let logoContainerView: UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        logoImageView.contentMode = .scaleAspectFill
        //logoImageView.backgroundColor = .red
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 75)
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = UIColor.rgb(red: 227, green: 127, blue: 187)
        return view
    }()
    
    let dontHaveAccountButton: UIButton = {
        lazy var button = UIButton(type: .system)

        let attributedTitle = NSMutableAttributedString(string: "don't have an account ?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: " sign up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 227, green: 127, blue: 187)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.setTitleColor(UIColor.rgb(red: 227, green: 127, blue: 187), for: .normal)

        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        lazy var button = UIButton(type: .system)

        let attributedTitle = NSMutableAttributedString(string: "already have an account ?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: " log in", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.rgb(red: 227, green: 127, blue: 187)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.setTitleColor(UIColor.rgb(red: 227, green: 127, blue: 187), for: .normal)

        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
//    let usernameTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "username"
//        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
//        tf.borderStyle = .roundedRect
//        tf.font = UIFont.systemFont(ofSize: 14)
//
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
//
//        return tf
//    }()
//
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty != true && passwordTextField.text?.isEmpty != true
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.rgb(red: 227, green: 127, blue: 187)
        }
        else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        }
    }
    
    
        let loginButton: UIButton = {
        lazy var button = UIButton(type: .system)
        button.setTitle("log in", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 227, green: 127, blue: 187)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleLogIn), for: .touchUpInside)

        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleLogIn(){
        print("you are now logged in")
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
            
            if let err = err {
                print("failed to sign in with email: ", err)
            }
            
            print("successfully logged back in with user: ", user?.user.uid ?? "")
            //let mainTabBarController = MainTabBarController()
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            
            mainTabBarController.setupViewControllers()
            self.dismiss(animated: true)
        })
    }
    
    @objc func handleShowSignUp(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationController?.isNavigationBarHidden = true
        view.addSubview(dontHaveAccountButton)
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        dontHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 50)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 150)
    
    }
}
