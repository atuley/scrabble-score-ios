//
//  ViewController.swift
//  JsonTest
//
//  Created by Alex Tuley on 1/10/18.
//  Copyright © 2018 Alex Tuley. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var wordParamTextField: UITextField!
    
    var wordParam = ""
    
    var scrService: ScrService = ScrabbleService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wordParamTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        set textField.text to a local variable
        wordParam = textField.text!
        
    }
    
    @IBAction func setText(_ sender: UIButton) {
        scrService.getScore(with: wordParam) {
            (scrScore, error) in
            if error != nil {
                // Deal with error here
                return
            } else if let scrScore = scrScore {
                self.scoreLabel.text = String(scrScore.score)
                print("WOOOOOOOOO", scrScore)
            }
        }
    }
}

