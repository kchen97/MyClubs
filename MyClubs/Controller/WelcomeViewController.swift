//
//  WelcomeViewController.swift
//  MyClubs
//
//  Created by Korman Chen on 10/29/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit
import ChameleonFramework

protocol RegisterAddDelegate {
    func configureItemNames(_ mode: String, _ firstTextFieldHolder: String, _ secondTextFieldHolder: String, _ thirdTextFieldHolder: String, _ fourthTextFieldHolder: String)
}

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var addClubButton: UIButton!
    
    var delegate : RegisterAddDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.backgroundColor = UIColor.flatMaroon()
        addClubButton.backgroundColor = UIColor.flatOrange()
        registerButton.backgroundColor = UIColor.flatWatermelon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToAddOrRegister(_ sender: UIButton) {
        if sender == registerButton {
            delegate?.configureItemNames("Register", "Email", "Username", "Password", "Confirm Password")
            performSegue(withIdentifier: "goToRegister", sender: self)
        }
        else if sender == addClubButton {
            delegate?.configureItemNames("Add", "Email", "Password", "Club Name", "Auth Code")
            performSegue(withIdentifier: "goToAddClub", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRegister" {
            self.delegate = segue.destination as! RegisterViewController
        }
    }
}

