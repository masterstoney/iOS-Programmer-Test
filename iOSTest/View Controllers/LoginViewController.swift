//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        client = LoginClient()
        title = "Login"
        self.navigationItem.backBarButtonItem?.title = ""
        emailTextField.padding(side: .leading, size: 24)
        passwordTextField.padding(side: .leading, size: 24)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor.init(red: 95/255, green: 96/255, blue: 99/255, alpha: 1.0)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .regular), .foregroundColor: UIColor.init(red: 95/255, green: 96/255, blue: 99/255, alpha: 1.0)])
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        
        guard let email = emailTextField.text,
              !email.isEmpty else {
            presentAlertVC(message: "Empty email field")
            return
        }
        guard let password = passwordTextField.text,
              !password.isEmpty else {
            presentAlertVC(message: "Empty password field")
            return
        }
        
        client?.login(withEmail: email, password: password, completion: { [weak self] (dict, error) in

            guard let self = self else {return}
            if let error = error {
                DispatchQueue.main.async {
                    self.presentAlertVC(message: error.localizedDescription)
                }
                return
            }

            guard let unwrappedDict = dict as? [String:String] else {return}
            DispatchQueue.main.async {
                self.presentAlertVC(title: unwrappedDict["code"]!,message: unwrappedDict["message"]!)
            }
        })
    }
    
    private func presentAlertVC(title: String = "Error", message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    
}
