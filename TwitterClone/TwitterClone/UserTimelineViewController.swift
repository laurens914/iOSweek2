//
//  UserTimelineViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/11/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit



class UserTimelineViewController: UIViewController, UITableViewDataSource
{    
    @IBOutlet weak var tableView: UITableView!
    var tweet: Tweet?
    var username: String?
    var tweets = [Tweet]() {
        didSet{
        self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUserTimelineView()
        setUpTableView()
        
    }
    func setUpTableView()
    {
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func setupUserTimelineView()
    {
        if let tweet = self.tweet{
            username = tweet.user?.screenName
            if let originalTweet = tweet.originalTweet{
                username = originalTweet.user?.screenName
            }
            
            
            
            if let username = self.username {
                self.navigationItem.title = username
                API.shared.getUserTweets(username, completion: {(tweets) -> () in
                    if let tweets = tweets{
                        self.tweets = tweets
                    }
                })
            }
        }
    }
    
    
}

extension UserTimelineViewController
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("TweetCell" , forIndexPath: indexPath) as! TweetCell
        tweetCell.tweet = tweets[indexPath.row]
        
        return tweetCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets.count
    }
}
