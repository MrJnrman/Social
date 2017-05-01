//
//  FeedVC.swift
//  Social
//
//  Created by Jamel Reid  on 4/30/17.
//  Copyright © 2017 Jamel Reid . All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signOutBtnPressed(_ sender: UIImageView) {
        
        let removeSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: KEY_UID)        
        if removeSuccessful == true {
            do {
                try FIRAuth.auth()?.signOut()
                performSegue(withIdentifier: "backToSignIn", sender: nil)
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
        }
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
