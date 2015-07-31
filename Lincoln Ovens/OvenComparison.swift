//
//  OvenComparison.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/28/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class OvenComparison: UIViewController {
	var ovensShowing = [true, true, true, true, true, true, true, true]
	let ovens = [""]

	var propertiesShowing = [true, true, true, true, true, true]
	let belt_widths = [""]
	let chamer_lengths = [""]
	let stackings = [""]
	let gasOrElectric = [""]
	let electricVentless = [""]
	let hasHalfPassDoor = [""]

	public func setArrays(isProperties: Bool, vals: Array<Bool>) {
		if isProperties {
			propertiesShowing = vals
		} else {
			ovensShowing = vals
		}
	}

	override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "showToggleOvens" {
			let view = (segue.destinationViewController as! UINavigationController).topViewController as! ToggleOvensAndProperties
			view.setDaScene(false, arrayOfVals: ovensShowing)
		} else {
			let view = (segue.destinationViewController as! UINavigationController).topViewController as! ToggleOvensAndProperties
			view.setDaScene(true, arrayOfVals: propertiesShowing)
		}
	}

	override public func viewDidLoad() {
		self.navigationItem.title = "Oven Comparison"
	}
}