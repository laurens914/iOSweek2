//
//  UserTimelineViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/11/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit



class UserTimelineViewController: UIViewController
{

    var tweet: Tweet?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let tweet = self.tweet, user = tweet.user {
            API.shared.getUserTweets(user.screenName, completion: {(tweets) -> () in
                if let tweets = tweets{
                for tweet in tweets{
                    print(tweet.text)
                }
              }
            })
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }



}
