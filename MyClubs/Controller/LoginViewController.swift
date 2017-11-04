//
//  LoginViewController.swift
//  MyClubs
//
//  Created by Korman Chen on 10/29/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit
import Firebase
import PKHUD
import ChameleonFramework

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        HUD.show(.progress)
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    self.displayErrorHUD((error?.localizedDescription)!)
                }
                else {
                    HUD.flash(.success, delay: 1.0)
                    self.performSegue(withIdentifier: "goFromLoginToClub", sender: self)
                }
            })
        }
    }
    
    func displayErrorHUD(_ subtitle: String) {
        let errorMessageHUD = PKHUDErrorView(title: "Error", subtitle: subtitle)
        PKHUD.sharedHUD.contentView = errorMessageHUD
        PKHUD.sharedHUD.show()
        PKHUD.sharedHUD.hide(afterDelay: 2.0)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
