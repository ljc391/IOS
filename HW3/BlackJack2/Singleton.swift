//
//  Singleton.swift
//  BlackJack2
//
//  Created by Elaine Chang on 2/26/15.
//  Copyright (c) 2015 Elaine Chang. All rights reserved.
//

import Foundation

class Singleton {
    var numofdecks:String = " "
    var numofplayers:String = " "
    
    class var sharedInstance: Singleton {
        struct Static {
            static let instance: Singleton = Singleton()
        }
        return Static.instance
    }
    
}
