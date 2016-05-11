//
//  MissionDetailsViewController.swift
//  BucketList
//
//  Created by Michael Arbogast on 5/9/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UITableViewController {
    @IBOutlet weak var newMissionTextField: UITextField!
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: MissionDetailsViewControllerDelegate?
    var missionToEdit: Mission?
//    print("ZAOOI")
//    print(missionToEdit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (missionToEdit != nil) {
            newMissionTextField.text = String(missionToEdit!.details!)
        }
    }
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem){
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        // if we are editing then run the "didFinishEditingMission" method
        if let mission = missionToEdit {
            print("made it 2", missionToEdit, newMissionTextField.text)
            mission.details = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission)
        } else {
            // we are adding so run the "didFinishAddingMission" method
            let mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
        }
    }
    
}