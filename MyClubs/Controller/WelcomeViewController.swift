//
//  WelcomeViewController.swift
//  MyClubs
//
//  Created by Korman Chen on 10/29/17.
//  Copyright © 2017 Korman Chen. All rights reserved.
//

import UIKit
import ChameleonFramework

enum RegisterControllerMode {
    case register
    case addClub
}

protocol RegisterAddDelegate {
    func configureItemNames(_ mode: RegisterControllerMode, _ firstTextFieldHolder: String, _ secondTextFieldHolder: String, _ thirdTextFieldHolder: String, _ fourthTextFieldHolder: String)
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
            performSegue(withIdentifier: "goToRegister", sender: self)
            delegate?.configureItemNames(.register, "Email", "Username", "Password", "Confirm Password")
            print("in register")
        }
        else if sender == addClubButton {
            performSegue(withIdentifier: "goToRegister", sender: self)
            print("In add club")
            delegate?.configureItemNames(.addClub, "Email", "Password", "Club Name", "Auth Code")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRegister" {
            self.delegate = segue.destination as! RegisterViewController
        }
    }
}

