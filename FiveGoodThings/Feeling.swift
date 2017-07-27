//
//  Feeling.swift
//  fiveGoodThings
//
//  Created by Devin Rice on 7/21/17.
//  Copyright © 2017 Devin Rice. All rights reserved.
//

import Foundation
import os.log

class Feeling: NSObject, NSCoding {
    
    //MARK: Properties
    
    let dateTime: Date
    let feelingValue: Int
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("feelings_data")
    
    //MARK: Types
    
    struct PropertyKey {
        static let dateTime = "dateTime"
        static let feelingValue = "feelingValue"
    }
    
    //MARK: Initialization
    
    init?(dateTime: Date, feelingValue: Int) {
        
        // The feeling must be between 0 and 10 inclusively
        guard (feelingValue >= 0) && (feelingValue <= 10) else {
            return nil
        }
        
        // Initialize stored properties.
        self.dateTime = dateTime
        self.feelingValue = feelingValue
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateTime, forKey: PropertyKey.dateTime)
        aCoder.encode(feelingValue, forKey: PropertyKey.feelingValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The dateTime is required. If we cannot decode a dateTime Date, the initializer should fail.
        guard let dateTime = aDecoder.decodeObject(forKey: PropertyKey.dateTime) as? Date else {
            os_log("Unable to decode the date for a feeling object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The feelingValue is required. If we cannot decode a feelingValue Int, the initializer should fail.
        let feelingValue = aDecoder.decodeInteger(forKey: PropertyKey.feelingValue)
        
        // Must call designated initializer.
        self.init(dateTime: dateTime, feelingValue: feelingValue)
    }
    
}
