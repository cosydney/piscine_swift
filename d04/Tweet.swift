//
//  Tweet.swift
//  d04
//
//  Created by Sydney COHEN on 6/1/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    let name : String
    let text : String
    var description: String {
        return "\(name), \(text)"
    }
}

