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

    func getTweets() {}
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

    private func updateTimeline() {}
}