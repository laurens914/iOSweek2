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
        update()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
    func setupTableView()
    {
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func update()
    {
        API.shared.getAccounts { (accounts) -> () in
            guard let accounts = accounts else {
                return
            }
            
            switch accounts.count {
                
            case 0:
                let alertController = UIAlertController(title: "No Accounts Found", message: "Add your account in Settings.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            case 1:
                API.shared.getTweetsForAccount(accounts[0], completion: {(tweets) -> () in
                    if let tweets = tweets {
                        self.tweets = tweets
                    }
                })
            default:
                let alertController = UIAlertController(title: "Choose an account", message: "", preferredStyle: .ActionSheet)
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == ProfileViewController.identifier() {
            guard let profileViewController = segue.destinationViewController as? ProfileViewController else {
                fatalError("Something is messed up..") }
            profileViewController.completion = { unowned in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        if segue.identifier == DetailViewController.identifier(){
            guard let detailViewController = segue.destinationViewController    as? DetailViewController else { fatalError() }
            guard let indexPath = self.tableView.indexPathForSelectedRow else {return}
            detailViewController.tweet = self.tweets[indexPath.row]
        }

      
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

