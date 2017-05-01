//
//  ViewController.swift
//  Social
//
//  Created by Jamel Reid  on 4/29/17.
//  Copyright © 2017 Jamel Reid . All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextField: FancyText!
    @IBOutlet weak var passwordTextField: FancyText!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            print("here")
            performSegue(withIdentifier: "gotoFeed", sender: nil)
        }

    }
    
    @IBAction func FBBtnPressed(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn([ ReadPermission.publicProfile ], viewController: self) { loginResult in
            switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login to Facebook.")
                case .success( _, _, let accessToken):
                    print("Logged in to Facebook!")
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                    self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("Successfully Authenticated with Firebase")
                
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        })
    }
    
    @IBAction func SigninPressed(_ sender: UIButton) {
        
        print("here")
       
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    print("Email User authenticated with Firebase")
                    
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        
                        if error == nil {
                            print("Email User Created with Firebase")
                            
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        } else {
                             print("Error occured - \(String(describing: error))")
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let saveSuccessful: Bool = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("Keychain Status: \(saveSuccessful)")
        performSegue(withIdentifier: "gotoFeed", sender: nil)
        
    }

}

