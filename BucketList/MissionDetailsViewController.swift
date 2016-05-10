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
//        newMissionTextField.text = missionToEdit
    }
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem){
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        // if we are editing then run the "didFinishEditingMission" method
        if var mission = missionToEdit {
            print("made it 2", missionToEdit, missionToEditIndexPath, newMissionTextField.text)
            mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishEditingMission: mission, atIndexPath: missionToEditIndexPath!)
        } else { // we are adding so run the "didFinishAddingMission" method
            let mission = newMissionTextField.text!
            delegate?.missionDetailsViewController(self, didFinishAddingMission: mission)
        }
    }
    
}
