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

extension NSHTTPURLResponse {
    var isSuccessful: Bool {
        var successful = false
        switch self.statusCode {
        case 100...199:
            print("Informational: \(self.statusCode)")
        case 200...299:
            print("Success: \(self.statusCode)")
            successful = true
        case 300...399:
            print("Redirect: \(self.statusCode)")
        case 400...499:
            print("Client error: \(self.statusCode)")
        case 500...599:
            print("Server error: \(self.statusCode)")
        default:
            print("Unknown response: \(self.statusCode)")
        }
        return successful
    }
}

class API {
    static let shared = API()
    private init() {}

    var account: ACAccount?

    func getAccounts(completion: (accounts: [ACAccount]?) -> ()) {
        login(completion)
    }

    func getTweetsForAccount(account: ACAccount, completion: (tweets: [Tweet]?) -> ()) {
        self.updateTimelineForAccount(account, completion: completion)
    }

    func getUser(completion: (user: User?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json"), parameters: nil)
        request.account = self.account
        request.performRequestWithHandler { (data: NSData!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            var user: User?

            if response.isSuccessful {
                JSONParser.userJSONFrom(data, completion: { (success, parsedUser) -> () in
                    user = parsedUser
                    completion(user: user)
                })
            }

        }
    }

    private func login(completion: (account: [ACAccount]?) -> ()) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            var accounts: [ACAccount]?

            if granted {
                accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount]
                print("\(accounts?.count) Twitter accounts found")
            }
            else {
                print("Access to Twitter accounts not granted.")
            }

            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(account: accounts)
            })
        }
    }

    private func updateTimelineForAccount(account: ACAccount, completion: (tweets: [Tweet]?) -> ()) {
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: NSURL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json"), parameters: nil)
        request.account = account
        request.performRequestWithHandler { (data: NSData!, response: NSHTTPURLResponse!, error: NSError!) -> Void in
            var tweets: [Tweet]?

            if response.isSuccessful {
                JSONParser.tweetJSONFrom(data, completion: { (success: Bool, parsedTweets: [Tweet]?) -> () in
                    guard success else {
                        print("JSON parsing failed.")
                        return
                    }
                    tweets = parsedTweets
                })
            }

            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(tweets: tweets)
            })
        }
    }
}