//
//  API.swift
//  TwitterClone
//
//  Created by Branton Boehm on 2/9/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation
import Accounts
import Social

class API {
    static let shared = API()
    private init() {}

    var account: ACAccount?

    func getTweets() {
        if account == nil {
            login({ (account: ACAccount?) -> () in
                self.account = account
            })
        }
    }

    func getUser() {}

    private func login(completion: (account: ACAccount?) -> ()) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            var account: ACAccount?

            if granted {
                if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
                    account = accounts.first
                }
            }

            completion(account: account)
        }
    }

    private func updateTimeline(completion: (tweets: [Tweet]?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        request.account = self.account
        request.performRequestWithHandler { (data: NSData!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            var tweets: [Tweet]?

            switch response.statusCode {
            case 100...199:
                print("Informational: \(response.statusCode)")
            case 200...299:
                print("Success: \(response.statusCode)")
                JSONParser.tweetJSONFrom(data, completion: { (success: Bool, parsedTweets: [Tweet]?) -> () in
                    guard success else {
                        print("JSON parsing failed.")
                        return
                    }
                    tweets = parsedTweets
                })
            case 300...399:
                print("Redirect: \(response.statusCode)")
            case 400...499:
                print("Client error: \(response.statusCode)")
            case 500...599:
                print("Server error: \(response.statusCode)")
            default:
                print("Unknown response: \(response.statusCode)")
            }

            completion(tweets: tweets)
        }
    }
}