//
//  PickOvenModel.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/31/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class PickOvenModel: UITableViewController {
    let ovens = ["2500", "1100", "1400/1600/3240", "3255", "3270"]
    let belt_widths = ["16", "18", "32", "32", "32"]
    let chamber_lengths = ["20.5", "28.25", "40.1875", "55", "75"]
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ovens.count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("oven", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = ovens[indexPath.row] as String
        return cell
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let specSheet = (segue.destinationViewController as! UINavigationController).topViewController as! CapacityCalculatorView
        let beltWidth = belt_widths[self.tableView.indexPathForSelectedRow()!.row]
        let chamberLength = chamber_lengths[self.tableView.indexPathForSelectedRow()!.row]
        
        
    }

}