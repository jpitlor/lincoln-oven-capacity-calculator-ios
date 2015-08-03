//
//  SpecSheetLinks.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/28/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class SpecSheetLinks: UITableViewController {
	let models = ["2500", "Ventless 2500", "1100", "Ventless 1100", "1400", "1600", "3240", "3255", "3270"]
	let file_names = ["p2500", "Ventless 2500", "p1100", "Ventless 1100", "p1400", "p1600", "p3240", "p3255", "p3270"]

	override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}

	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("specsheet", forIndexPath: indexPath) 

		cell.textLabel!.text = models[indexPath.row] as String
		return cell
	}
    
	override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let specSheet = (segue.destinationViewController as! UINavigationController).topViewController as! SpecSheet
		let file_name = file_names[self.tableView.indexPathForSelectedRow!.row]
        let model = models[self.tableView.indexPathForSelectedRow!.row]
        specSheet.setSpecSheet(file_name, model: model)
	}
}