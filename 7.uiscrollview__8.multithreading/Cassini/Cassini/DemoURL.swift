//
//  DemoURL.swift
//  Cassini
//
//  Created by Christopher Lee on 27/10/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct DemoURL {
    static let stanford = URL(string: "http://www-media.stanford.edu/wp-content/uploads/2017/03/24182714/about_landing-1.jpg")
    
    static var NASA: Dictionary<String,URL> = {
        let NASAURLStrings = [
            "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth": "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn": "http://www.nasa.gov/sites/default/files/satirm_collage.jpg"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
