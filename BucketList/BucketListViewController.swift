//
//  ViewController.swift
//  BucketList
//
//  Created by Michael Arbogast on 5/9/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
    var missions = ["Sky diving", "Live in Hawaii"]
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewMission" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        } else if segue.identifier == "EditMission" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! MissionDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            //set which we want to edit:
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.missionToEdit = missions[indexPath.row]
                controller.missionToEditIndexPath = indexPath.row
            }
        }
    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String) {
        dismissViewControllerAnimated(true, completion: nil)
        missions.append(mission)
        tableView.reloadData()
    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int) {
        print("attempting to finish editing")
        dismissViewControllerAnimated(true, completion: nil)
        missions.removeAtIndex(indexPath)
        missions.insert(mission, atIndex: indexPath)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row]
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return missions.count
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        missions.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("EditMission", sender: tableView.cellForRowAtIndexPath(indexPath))
    }

}