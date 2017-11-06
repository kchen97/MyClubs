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
    @IBOutlet weak var textFieldOne: UITextField!
    @IBOutlet weak var textFieldTwo: UITextField!
    @IBOutlet weak var textFieldThree: UITextField!
    @IBOutlet weak var textFieldFour: UITextField!
    
    let code = "Jackie"
    var registerMode : RegisterControllerMode = .register // Is this a VC that registers a user or a club
    var holderOne : String?
    var holderTwo : String?
    var holderThree : String?
    var holderFour : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        textFieldOne.delegate = self
        textFieldTwo.delegate = self
        textFieldThree.delegate = self
        textFieldFour.delegate = self
        
        configureUI()
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
        if registerMode == .register {
            addUser()
        }
        else {
            addClub()
        }
    }
    
    func addUser() {
        if let email = textFieldOne.text, let username = textFieldTwo.text, let password = textFieldThree.text, let confirmedPassword = textFieldFour.text {
            
            if password == confirmedPassword {
                FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print((error?.localizedDescription)!)
                        self.displayErrorHUD((error?.localizedDescription)!)
                    }
                    else {
                        print("Successfully created user")
                        HUD.flash(.success, delay: 1.5)
                        let usersRef = FIRDatabase.database().reference().child("Users")
                        usersRef.setValue((user?.uid)!)
                        
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
    
    func addClub() {
        if let email = textFieldOne.text, let password = textFieldTwo.text, let clubName = textFieldThree.text, let authCode = textFieldFour.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    self.displayErrorHUD((error?.localizedDescription)!)
                }
                else {
                    if authCode == self.code {
                        let databaseRef = FIRDatabase.database().reference().child(clubName)
                        let firstUser = ["Email": email, "Title": "President"]
                        
                        databaseRef.setValue(firstUser) { (error, reference) in
                            if error != nil {
                                print((error?.localizedDescription)!)
                                self.displayErrorHUD((error?.localizedDescription)!)
                            }
                            else {
                                print("Successfully created club!")
                                HUD.flash(.success, delay: 1.5)
                                let databaseRef = FIRDatabase.database().reference().child("Users").child((user?.uid)!)
                                databaseRef.setValue(clubName)
                                
                                self.performSegue(withIdentifier: "goFromRegisterToClub", sender: self)
                            }
                        }
                    }
                    else {
                        self.displayErrorHUD("Invalid code: \(authCode)")
                    }
                }
            })
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
    
    func configureUI() {
        if registerMode == .register {
            navigationItem.title = "Register"
            textFieldThree.isSecureTextEntry = true
            textFieldFour.isSecureTextEntry = true
        }
        else {
            navigationItem.title = "Add Club"
            textFieldTwo.isSecureTextEntry = true
        }
        
        textFieldOne.placeholder = holderOne
        textFieldTwo.placeholder = holderTwo
        textFieldThree.placeholder = holderThree
        textFieldFour.placeholder = holderFour
    }
    
    func configureItemNames(_ mode: RegisterControllerMode, _ firstTextFieldHolder: String, _ secondTextFieldHolder: String, _ thirdTextFieldHolder: String, _ fourthTextFieldHolder: String) {
        
        registerMode = mode
        holderOne = firstTextFieldHolder
        holderTwo = secondTextFieldHolder
        holderThree = thirdTextFieldHolder
        holderFour = fourthTextFieldHolder
    }

}
