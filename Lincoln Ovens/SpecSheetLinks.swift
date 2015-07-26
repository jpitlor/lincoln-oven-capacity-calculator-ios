//
//  SpecSheetLinks.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/23/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

class SpecSheetLinks: UITableViewController {
	var objects = [AnyObject]()
	let oven_models = ["2500", "Ventless 2500", "1100", "Ventless 1100", "1400", "1600", "3240", "3255", "3270"]
	let oven_model_links = []

	override func viewDidLoad() {
		super.viewDidLoad()

		let alertController = UIAlertController(title: "iOScreator", message:
			"Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
		alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))

		self.presentViewController(alertController, animated: true, completion: nil)
//
//		for var dracula = 0; dracula < oven_models.count; dracula++ {
//			objects.insert(oven_models[dracula], atIndex: dracula)
//		}
//
//		let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//		self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .None)
	}
}