//
//  ViewController.swift
//  OnTheMap
//
//  Created by DT on 8/22/20.
//  Copyright © 2020 DT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var webSignUp: UITextField!
    @IBOutlet weak var webLink: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        setLoggingIn(true)
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
       }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        DispatchQueue.main.async {
            if success {
                print("hello")
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            } else {
                print("hello 5")
                self.showLoginFailure(message: error?.localizedDescription ?? "")
            }
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            print("hello 2")
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            print("hello 6")
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            print("hello 4")
            UdacityClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
        }
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
    
    override func viewDidLoad() {
        let attributedString = NSMutableAttributedString(string: "Don't have an account? Sign up.")
        attributedString.addAttribute(.link, value: "https://auth.udacity.com/sign-up", range: NSRange(location: 23, length: 8))

        webLink.attributedText = attributedString
    }
    
    func textView(_ textView: UILabel, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }


}

