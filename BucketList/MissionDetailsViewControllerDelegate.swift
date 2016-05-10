//
//  MissionDetailsViewControllerDelegate.swift
//  BucketList
//
//  Created by Michael Arbogast on 5/9/16.
//  Copyright © 2016 Michael Arbogast. All rights reserved.
//

import Foundation

protocol MissionDetailsViewControllerDelegate: class {
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishAddingMission mission: String)
    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishEditingMission mission: String, atIndexPath indexPath: Int)
//    func missionDetailsViewController(controller: MissionDetailsViewController, didFinishDeletingMission mission: String, atIndexPath indexPath: Int)
}