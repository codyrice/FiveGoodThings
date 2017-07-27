//
//  GoodThings.swift
//  fiveGoodThings
//
//  Created by Devin Rice on 7/25/17.
//  Copyright © 2017 Devin Rice. All rights reserved.
//

import Foundation
import os.log

class GoodThings: NSObject, NSCoding {
    
    //MARK: Properties
    
    let dateTime: Date
    let goodThingsItems: Array<String>
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("goodthings_data")
    
    //MARK: Types
    
    struct PropertyKey {
        static let dateTime = "dateTime"
        static let goodThingsItems = "goodThingsItems"
    }
    
    //MARK: Initialization
    
    init?(dateTime: Date, goodThingsItems: Array<String>) {
        
        // Initialize stored properties.
        self.dateTime = dateTime
        self.goodThingsItems = goodThingsItems
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateTime, forKey: PropertyKey.dateTime)
        aCoder.encode(goodThingsItems, forKey: PropertyKey.goodThingsItems)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The date is required. If we cannot decode a dateTime Date, the initializer should fail.
        guard let dateTime = aDecoder.decodeObject(forKey: PropertyKey.dateTime) as? Date else {
            os_log("Unable to decode the date for a good thing object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The goodThingsItems is required. If we cannot decode a goodThingsItems [String], the initializer should fail.
        guard let goodThingsItems = aDecoder.decodeObject(forKey: PropertyKey.goodThingsItems) as? [String] else {
            os_log("Unable to decode the list of good things for a good thing object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(dateTime: dateTime, goodThingsItems: goodThingsItems)
    }
    
}
