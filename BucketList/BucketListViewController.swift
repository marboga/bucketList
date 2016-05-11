//
//  ViewController.swift
//  BucketList
//
//  Created by Michael Arbogast on 5/9/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, CancelButtonDelegate, MissionDetailsViewControllerDelegate {
    var segueEditMode = false
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var missions = [Mission]()
    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("preparingForSegue")
        let navigationController = segue.destinationViewController as! UINavigationController
        let controller = navigationController.topViewController as! MissionDetailsViewController
        controller.cancelButtonDelegate = self
        controller.delegate = self
        //set which we want to edit:
        if segueEditMode == true {
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                print(missions[indexPath.row])
                controller.missionToEdit = missions[indexPath.row]
                segueEditMode = false
            }
        }
    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission missionText: String) {
        dismissViewControllerAnimated(true, completion: nil)
        print(missionText, "missionText", missions)
//THIS will create a new one
        let entity = NSEntityDescription.entityForName("Mission", inManagedObjectContext: managedObjectContext)
        let mission = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        mission.setValue(missionText, forKey: "details")
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                
                print("success!")
            } catch {
                print("\(error)")
            }
        }
        fetchAllMissions()
        tableView.reloadData()
    }
    func fetchAllMissions() {
        let userRequest = NSFetchRequest(entityName: "Mission")
        do {
        let results = try managedObjectContext.executeFetchRequest(userRequest)
        missions = results as! [Mission]
        
        } catch {
        print("\(error)")
        }
    }
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission missionText: Mission) {
        print("attempting to finish editing")
        dismissViewControllerAnimated(true, completion: nil)
        let entity = NSEntityDescription.entityForName("Mission", inManagedObjectContext: managedObjectContext)
        let mission = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        mission.setValue(String(missionText), forKey: "details")
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                
                print("success!")
            } catch {
                print("\(error)")
            }
        }

//        missions.removeAtIndex(indexPath)
//        missions.insert(mission, atIndex: indexPath)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllMissions()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MissionCell")!
        // if the cell has a text label, set it to the model that is corresponding to the row in array
        cell.textLabel?.text = missions[indexPath.row].details
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
    //edit
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        segueEditMode = true
        performSegueWithIdentifier("DetailsSegue", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
    @IBAction func addBarButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("DetailsSegue", sender: UIBarButtonItem.self)
    }

}