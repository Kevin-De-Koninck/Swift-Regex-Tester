//
//  ViewController.swift
//  test
//
//  Created by testing on 02/02/2017.
//  Copyright © 2017 testing. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var regexInput: NSTextField!
    @IBOutlet weak var inputString: NSTextField!
    @IBOutlet weak var outputString: NSTextField!
    @IBOutlet weak var nrOfMatches: NSTextField!
    @IBOutlet weak var startIndex: NSTextField!
    @IBOutlet weak var matchLength: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regexInput.stringValue = "(?<=^\\[download\\].)[0-9.]+\\%"
        inputString.stringValue = "[download] 12.5% of ~4,62KiB at Unknown speed ETA 00:00"
        nrOfMatches.stringValue = "0"
        startIndex.stringValue = "0"
        matchLength.stringValue = "0"
        
    }
    
    @IBAction func push(_ sender: Any) {
        outputString.stringValue = ""
        
        let REGEX_PATTERN = regexInput.stringValue
        let str = inputString.stringValue

        do{
            //create regex and find matches
            let regex = try NSRegularExpression(pattern: REGEX_PATTERN, options: [])
            let matches = regex.matches(in: str, options: [], range: NSRange(location: 0, length: str.characters.count))
            
            if(matches.count > 0){
                //Get location of first match and length of match
                let range = matches[0].rangeAt(0)
                
                //convert range to index
                var index = str.index(str.startIndex, offsetBy: range.location + range.length)
                
                //get substring from index
                var outputStr = str.substring(to: index)
                index = str.index(str.startIndex, offsetBy: range.location)
                outputStr = outputStr.substring(from: index)
                
                //set GUI
                nrOfMatches.stringValue = "\(matches.count)"
                startIndex.stringValue = "\(range.location)"
                matchLength.stringValue = "\(range.length)"
                outputString.stringValue = outputStr
            } else {
                outputString.stringValue = ""
                nrOfMatches.stringValue = "0"
                startIndex.stringValue = "-"
                matchLength.stringValue = "-"
            }
            
        } catch _ {
            outputString.stringValue = "-- Bad reggex --"
            nrOfMatches.stringValue = "0"
            startIndex.stringValue = "-"
            matchLength.stringValue = "-"
        }
        
    }
    
    
}

