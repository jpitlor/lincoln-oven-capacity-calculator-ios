//
//  MainMenu.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/22/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import UIKit

class MainMenu: UITableViewController {

	var detailViewController: UIViewController? = nil

	override func awakeFromNib() {
		super.awakeFromNib()
		if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
			self.clearsSelectionOnViewWillAppear = false
			self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		if let split = self.splitViewController {
			let controllers = split.viewControllers
			self.detailViewController = controllers[controllers.count - 1].topViewController as UIViewController
		}
	}
}

