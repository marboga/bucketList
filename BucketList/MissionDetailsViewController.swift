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
    var missionToEdit: String?
    var missionToEditIndexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newMissionTextField.text = missionToEdit
    }
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem){
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        print("made it 1")
        // if we are editing then run the "didFinishEditingMission" method
        if var mission = missionToEdit {
            print("made it 2", missionToEdit, missionToEditIndexPath, newMissionTextField.text)
            mission = newMissionTextField.text!
            print("made it 6")
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission, atIndexPath: missionToEditIndexPath!)
        } else { // we are adding so run the "didFinishAddingMission" method
            print("made it 3")
            let mission = newMissionTextField.text!
            print("made it 5")
            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
        }
        print("made it 4")
    }
    
}
