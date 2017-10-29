//
//  TwitterUser.swift
//  Smashtag
//
//  Created by Christopher Lee on 29/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class TwitterUser: NSManagedObject {
    static func findOrCreateTwitterUser(matching twitterInfo: Twitter.User, in context: NSManagedObjectContext) throws -> TwitterUser {
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.screenName)
        
        do {
            let matches = try context.fetch(request)
            if (matches.count > 0) {
                assert(matches.count > 1, "TwitterUser.findOrCreateTwitterUser -- Database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.screenName
        twitterUser.name = twitterInfo.name
        return twitterUser
    }
}
