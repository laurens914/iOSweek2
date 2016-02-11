//
//  JSONParser.swift
//  TwitterClone
//
//  Created by Lauren Spatz on 2/8/16.
//  Copyright © 2016 Lauren Spatz. All rights reserved.
//

import UIKit

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()
typealias JSONParserUserCompletion = (success: Bool, user: User?) -> ()

class JSONParser
{
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
    {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String: AnyObject]]{
                
                var tweets = [Tweet]()
                
                for tweetJSON in rootObject {
                    guard let tweet = self.tweetFromJSON(tweetJSON) else {return}
                    
                    if let originalTweet = self.originalTweet(tweetJSON) {
                        tweet.originalTweet = originalTweet
                    }
                    
                    tweets.append(tweet)
                    
                }
                //Completion

                    completion(success: true, tweets: tweets)
            } else {
               completion(success: false, tweets: nil) 
            }
        } catch _ { completion(success: false, tweets: nil) }
    }
    
    class func userJSONFrom(data: NSData, completion: JSONParserUserCompletion)
    {
        do {
            var user: User?
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String: AnyObject]{
                user = userFromTweetJSON(rootObject)

            }
            completion(success: true, user: user)
        } catch _ { completion(success: false, user: nil) }
    }
    
    //MARK: Helper Functions 
    
    class func userFromTweetJSON(tweetJSON: [String: AnyObject]) -> User
    {
        guard let name = tweetJSON["name"] as? String else { fatalError("Failed to Parse the Name. Something is wrong with JSON.") }
        guard let profileImageUrl = tweetJSON["profile_image_url"] as? String else { fatalError("Failed to Parse the profile image url. Something is wrong with JSON.") }
        guard let location = tweetJSON["location"] as? String else { fatalError("Failed to Parse the location. Something is wrong with JSON.") }
        guard let screenName = tweetJSON["screen_name"] as? String else { fatalError() }
        return User(name: name, profileImageUrl: profileImageUrl, location: location, screenName: screenName)
    }
    
    class func tweetFromJSON(tweetJSON: [String: AnyObject]) -> Tweet?
    {
        guard let text = tweetJSON ["text"] as? String else { return nil }
        guard let id = tweetJSON ["id_str"] as? String else { return nil }
        guard let userJSON = tweetJSON ["user"] as? [String: AnyObject] else { return nil }
        
        return Tweet( text: text, id: id, user: self.userFromTweetJSON(userJSON))
    
    }
    
    class func originalTweet (tweetJSON: [String:AnyObject]) -> Tweet?
    {
        guard let retweetObject = tweetJSON["retweeted_status"] as? [String:AnyObject] else { return nil}
        guard let tweet = self.tweetFromJSON(retweetObject) else { return nil }
        return tweet
        
        
    }
    
    
    
}