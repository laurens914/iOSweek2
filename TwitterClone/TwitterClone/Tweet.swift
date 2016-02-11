//
//  Tweet.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/8/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import Foundation

class Tweet
{
    let text: String
    let id: String
    let user: User?
    
    var originalTweet: Tweet?
    
    init(text: String, id: String, user: User? = nil, originalTweet: Tweet? = nil)
    {
        self.text = text
        self.id = id
        self.user = user
        self.originalTweet = originalTweet
    }
}