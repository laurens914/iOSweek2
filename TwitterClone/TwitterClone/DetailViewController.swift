//
//  DetailViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/10/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Identity
{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var tweet: Tweet?
    
    static func identifier () -> String
    {
        return "DetailViewController"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setupApperance()
        self.setupDetailViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupDetailViewController()
    {
        if let tweet = self.tweet {
            self.navigationItem.title = "Tweet"
            self.tweetText.text = tweet.text
            self.userName.text = tweet.user?.name
            if let profileImageUrl = tweet.user?.profileImageUrl{
                self.profileImage((profileImageUrl), completion: {image -> () in
                    self.profileImageView.image = image
                })
            }
            if let originalTweet = tweet.originalTweet{
                self.navigationItem.title = "Retweet"
                self.tweetText.text = originalTweet.text
                self.userName.text = originalTweet.user?.name
                if let originalProfileImageUrl = originalTweet.user?.profileImageUrl{
                    self.profileImage((originalProfileImageUrl), completion: {image -> () in
                    self.profileImageView.image = image
                    })
                }
            }
        }
    }
    
    func profileImage(key: String, completion: (image:UIImage) -> ())
    {
        if let image = SimpleCache.shared.image(key){
            completion(image:image)
            return
        }
        API.shared.getImage(key) {image -> () in
            completion(image: image)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "UserTimelineViewController" {
            let userTimelineViewController = segue.destinationViewController as! UserTimelineViewController
            userTimelineViewController.tweet = self.tweet
        }
    }
    
}












