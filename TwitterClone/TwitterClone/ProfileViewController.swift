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
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var username: UILabel!
    
    
    var completion: ProfileViewControllerCompletion?
    var user: User?
    
    static func identifier () -> String
    {
        return "ProfileViewController"
    }
    override func viewWillAppear(animated: Bool)
    {
       super.viewWillAppear(animated)
        self.setupProfileViewController()
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
    
    
    func setupProfileViewController()
    {
        API.shared.getUser{ (user) -> () in
            if let user = user {
                //print(self.username.text)
                self.username.text = user.name
                //print(self.username.text)
                self.location.text = user.location
                if let image = SimpleCache.shared.image(user.profileImageUrl){
                    self.userImg.image = image
                    return
                }
                API.shared.getImage(user.profileImageUrl, completion: { (image) -> () in
                    SimpleCache.shared.setImage(image, key: user.profileImageUrl)
                    self.userImg.image = image
                })
            }
            
        }
    }

}

