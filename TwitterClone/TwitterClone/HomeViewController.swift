//
//  ViewController.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/8/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit
import Accounts

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
    }


    override func viewDidAppear(animated: Bool) {
        API.shared.getAccounts { (accounts) -> () in
            let alertController = UIAlertController(title: "Which account?", message: "Pick one!", preferredStyle: UIAlertControllerStyle.ActionSheet)
            guard let accounts = accounts else {
                return
            }

            for account in accounts {
                alertController.addAction(UIAlertAction(title: account.username, style: .Default, handler: {(_) -> () in
                    API.shared.getTweetsForAccount(account, completion: {(tweets) -> () in
                        if let tweets = tweets {
                            self.tweets = tweets
                        }
                    })
                }))
            }

            self.presentViewController(alertController, animated: true, completion: nil)
        }
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
    }
}


extension HomeViewController
{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell" , forIndexPath: indexPath)
        let tweet = tweets[indexPath.row]
        tweetCell.textLabel?.text = tweet.text
        tweetCell.detailTextLabel?.text = tweet.user?.name
        return tweetCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets.count
    }

}

