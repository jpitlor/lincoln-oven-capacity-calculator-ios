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
	var ovensShowing = [true, true, true, true, true, true, true]
	let ovens = ["2500", "1100", "1400", "1600", "3240", "3255", "3270"]

	var propertiesShowing = [true, true, true, true, true, true]
	let belt_widths = ["16", "18", "32", "32", "32" ,"32", "32"]
	let chamer_lengths = ["20", "28", "40", "40", "40", "55", "70"]
	let stackings = ["Double", "Triple", "Double", "Triple", "Triple", "Triple", "Triple"]
	let gasOrElectric = ["Electric", "Both" , "Both" ,"Both" ,"Both", "Gas", "Gas"]
	let electricVentless = ["Yes", "Yes", "No", "No", "No", "No", "No"]
	let hasHalfPassDoor = ["No", "Yes", "Yes", "Yes", "Yes", "Yes", "Yes"]

    @IBOutlet weak var ovenModelNameTable: UITableView!
    @IBOutlet weak var tableBody: UIScrollView!
    
	public func setArrays(isProperties: Bool, vals: Array<Bool>) {
		if isProperties {
			propertiesShowing = vals
		} else {
			ovensShowing = vals
		}
        refreshTable()
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
//        let popup: UIViewController = ToggleOvensAndProperties()
//        self.presentViewController(popup, animated: true, completion: nil)
    }
    
    override public func viewDidAppear(animated: Bool) {
        NSLog("%@",self.navigationController!.viewControllers)
    }
    
    private func refreshTable() {

    }
}