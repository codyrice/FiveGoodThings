//
//  ViewController.swift
//  FiveGoodThings
//
//  Created by Devin Rice on 7/25/17.
//  Copyright © 2017 Devin Rice. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\\
        
        if let loadedFeelings = loadFeelingsList() {
            feelingsList = loadedFeelings
        }
        
        if let loadedGoodThings = loadGoodThingsList() {
            goodThingsList = loadedGoodThings
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Variable Declarations
    
    var feelingsList: Array<Feeling> = []
    
    var goodThingsList: Array<GoodThings> = []
    
    //MARK: Outlet Declarations

    @IBOutlet weak var feelingSlider: UISlider!

    @IBOutlet weak var feelingSliderLabel: UILabel!
    
    @IBOutlet weak var feelingSliderSaveButton: UIButton!
    
    @IBOutlet var goodThingsTextFields: [UITextField]!
    
    @IBOutlet weak var goodThingsSaveButton: UIButton!
    
    //Mark: Actions
    
    @IBAction func feelingSliderValueChange(_ sender: UISlider) {
        
        let sliderValue = Int(feelingSlider.value)
        
        feelingSliderLabel.text = String(sliderValue)
        
    }
    
    @IBAction func feelingSliderSaveButtonClick(_ sender: UIButton) {
        
        let feelingValue = Int(feelingSlider.value)
        let dateTime = Date.init()
        
        let feeling: Feeling = Feeling.init(dateTime: dateTime, feelingValue: feelingValue)!
        
        feelingsList.append(feeling)
        
        saveFeelingsList(feelingsList: feelingsList)
    }
    
    
    
    @IBAction func goodThingsSaveButtonClick(_ sender: UIButton) {
        
        let dateTime = Date.init()
        let goodThingsTextEntries = goodThingsTextFields.map {
            (UITextField) -> String in UITextField.text!
        }
        
        let goodThings: GoodThings = GoodThings.init(dateTime: dateTime, goodThingsItems: goodThingsTextEntries)!
        
        goodThingsList.append(goodThings)
        
        saveGoodThingsList(goodThingsList: goodThingsList)
        
    }
    //MARK: Private Functions
    
    //MARK: Encoding Functions
    
    private func saveFeelingsList(feelingsList: Array<Feeling>) {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(feelingsList, toFile: Feeling.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Feelings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save feelings...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadFeelingsList() -> Array<Feeling>? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Feeling.ArchiveURL.path) as? Array<Feeling>
        
    }
    
    private func saveGoodThingsList(goodThingsList: Array<GoodThings>) {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(goodThingsList, toFile: GoodThings.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("GoodThings successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save goodthings...", log: OSLog.default, type: .error)
        }
        
    }
    
    private func loadGoodThingsList() -> Array<GoodThings>? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: GoodThings.ArchiveURL.path) as? Array<GoodThings>
        
    }

    
}

