//
//  Tweet.swift
//  Smashtag
//
//  Created by Christopher Lee on 29/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Tweet: NSManagedObject {
    // Looks in database and finds it
    class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) throws -> Tweet {
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)
        
        do {
            let matches = try context.fetch(request)
            if (matches.count > 0) {
                assert(matches.count == 0 1, "Tweet.findOrCreateTweet -- Database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.text
        tweet.created = twitterInfo.created
        tweet.tweeter = try? TwitterUser.findOrCreateTwitterUser(matching: twitterInfo.user, in: context)
        return tweet
    }
}
