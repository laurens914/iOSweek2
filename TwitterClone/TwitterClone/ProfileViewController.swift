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
        self.setupProfileViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
@IBAction func dismissButton(sender: AnyObject) {
    guard let completion = self.completion else { return }
    completion()
}

        
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var username: UILabel!
   
    func setupProfileViewController ()
    {
        
        self.username.text = "michael"
        self.location.text = "Seattle, WA"
        
        if let user = self.user {

        //
        }
        
    }
    
  
}
