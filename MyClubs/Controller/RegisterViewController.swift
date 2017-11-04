//
//  RegisterViewController.swift
//  MyClubs
//
//  Created by Korman Chen on 10/29/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit
import Firebase
import PKHUD

class RegisterViewController: UIViewController, UITextFieldDelegate, RegisterAddDelegate {
    
    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Actions
    @IBAction func createButtonPresed(_ sender: UIButton) {
        
        HUD.show(.progress)
        
        if let email = emailTextField.text, let username = userNameTextField.text, let password = passwordTextField.text, let confirmedPassword = confirmPasswordTextField.text {
            
            if password == confirmedPassword {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print((error?.localizedDescription)!)
                        self.displayErrorHUD((error?.localizedDescription)!)
                    }
                    else {
                        print("Successfully created user")
                        HUD.flash(.success, delay: 1.5)
                        self.performSegue(withIdentifier: "goFromRegisterToClub", sender: self)
                    }
                })
            }
            else {
                displayErrorHUD("Passwords do not match.")
            }
        }
        else {
            displayErrorHUD("Missing some requirements.")
        }
    }
    
    func displayErrorHUD(_ subtitle: String) {
        let errorMessageHUD = PKHUDErrorView(title: "Error", subtitle: subtitle)
        PKHUD.sharedHUD.contentView = errorMessageHUD
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
    }
    
    func configureItemNames(_ mode: String, _ firstTextFieldHolder: String, _ secondTextFieldHolder: String, _ thirdTextFieldHolder: String, _ fourthTextFieldHolder: String) {
        
        //Complete this
    }

}
