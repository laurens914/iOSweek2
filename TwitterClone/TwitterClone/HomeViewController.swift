//
//  ViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/8/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource
{
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    {
        didSet
        {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupTableView()
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }

    func setupTableView()
    {
       self.tableView.dataSource = self
    }
    func update()
    {
        API.shared.getTweets { (tweets) -> () in
            if let tweets = tweets {
                self.tweets = tweets
            }
        }
    }
}


extension HomeViewController
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell" , forIndexPath: indexPath)
        let tweetText = tweets[indexPath.row].text
        tweetCell.textLabel?.text = tweetText
        return tweetCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets.count
    }

}

