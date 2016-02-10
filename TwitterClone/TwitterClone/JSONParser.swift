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
                    if let text = tweetJSON["text"] as? String,
                        id = tweetJSON["id_str"] as? String,
                        userJSON = tweetJSON["user"] as? [String: AnyObject]{
                            
                            let user = self.userFromTweetJSON(userJSON)
                            let tweet = Tweet(text: text, id: id, user: user)
                            
                            tweets.append(tweet)
                    }
                }
                //Completion
                completion(success: true, tweets: tweets)
            } else {
                completion(success: false, tweets:nil)
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
        return User(name: name, profileImageUrl: profileImageUrl, location: location)
    }
}