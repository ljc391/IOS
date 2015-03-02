//
//  ViewController.swift
//  BlackJack2
//
//  Created by Elaine Chang on 2/26/15.
//  Copyright (c) 2015 Elaine Chang. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIActionSheetDelegate {

    @IBOutlet weak var Players: UITextField!
    @IBOutlet weak var Cards: UITextField!
    var CurrentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Players.delegate = self
        Cards.delegate = self
        Players.text = "2"
        Cards.text = "3"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField!) {
        CurrentTextField = textField
        Players.resignFirstResponder()
        Cards.resignFirstResponder()
        showOptions()
    }
    
    func actionSheet(myActionSheet: UIActionSheet!, clickedButtonAtIndex buttonIndex: Int){
        CurrentTextField.text = myActionSheet.buttonTitleAtIndex(buttonIndex)
    }

    func showOptions() {
        if CurrentTextField.tag == 1 {
            let actionSheet = UIActionSheet(title: "Choose How Many Players", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "1", "2", "3", "4", "5")
            actionSheet.showInView(self.view)
        } else {
            let actionSheet = UIActionSheet(title: "Choose Deck of Cards", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "3", "4", "5", "6")
            actionSheet.showInView(self.view)
        }
    }
    
    @IBAction func Confirm(sender: AnyObject) {
        Singleton.sharedInstance.numofdecks = Cards.text
        Singleton.sharedInstance.numofplayers = Players.text
        self.performSegueWithIdentifier("ToPlay", sender: self)
    }
}

