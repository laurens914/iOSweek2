//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/10/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

typealias ProfileViewControllerCompletion = () -> ()

class ProfileViewController: UIViewController, Identity
{
    var completion: ProfileViewControllerCompletion?
    var user: User?
    
    static func identifier () -> String
    {
        return "ProfileViewController"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
@IBAction func dismissButton(sender: AnyObject) {
    guard let completion = self.completion else { return }
    completion()
}

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func setupProfileViewController ()
    {
        if let user = self.user {
          self.username.text = user.name
        }
        
    }
    
  
}
