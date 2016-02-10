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
    @IBOutlet weak var tweetText: UILabel!
    
    var tweet: Tweet?
    
    static func identifier () -> String
    {
        return "DetailViewController"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDetailViewController()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupDetailViewController()
    {
        self.navigationItem.title = "Tweet"
        
        if let tweet = self.tweet {
            self.tweetText.text = tweet.text 
            if let originalTweet = tweet.originalTweet{
                self.navigationItem.title = "Retweet"
                self.tweetText.text = originalTweet.text
            }
        }
    }
}