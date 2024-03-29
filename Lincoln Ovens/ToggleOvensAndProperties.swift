//
//  ToggleOvens.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/29/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class ToggleOvensAndProperties:UITableViewController {
	let properties = ["Belt Width", "Chamber Length", "Stacking", "Gas Or Electric", "Electric Ventless", "Has Half Pass Door"]
	let ovens = ["2500", "1100", "1400", "1600", "3240", "3255", "3270"]

	var tempPropertiesChecked = [true, true, true, true, true, true]
	var tempOvensChecked = [false, false, false, false, false, false, false]

	var isProperty = false
    
    @IBAction func save(sender: UIBarButtonItem) {
        var count = 0
        if isProperty {
            for bool in tempPropertiesChecked {
                if bool {
                    count++
                }
            }
            if count >= 1 {
                self.performSegueWithIdentifier("save", sender: self)
            } else {
                let popup: UIAlertController = UIAlertController(title: "Please select at least 1 property to view", message: nil, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) {
                    (action) in
                    // Do nothing
                }
                popup.addAction(OKAction)
                self.presentViewController(popup, animated: true, completion: nil)
            }
        } else {
            for bool in tempOvensChecked {
                if bool {
                    count++
                }
            }
            if count >= 2 {
                self.performSegueWithIdentifier("save", sender: self)
            } else {
                let popup: UIAlertController = UIAlertController(title: "Please select at least 2 ovens to compare", message: nil, preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) {
                    (action) in
                    // Do nothing
                }
                popup.addAction(OKAction)
                self.presentViewController(popup, animated: true, completion: nil)
            }
        }        
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    public func setDaScene(val: Bool, arrayOfVals: Array<Bool>) {
		isProperty = val
        
		if val {
			tempPropertiesChecked = arrayOfVals
            self.navigationItem.title = "Toggle Properties"
		} else {
            tempOvensChecked = arrayOfVals
            self.navigationItem.title = "Toggle Ovens"
		}
	}

	override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let arr: Array<Bool>
		if isProperty {
			arr = tempPropertiesChecked
		} else {
			arr = tempOvensChecked
		}
        
        let oc = (segue.destinationViewController as! UINavigationController).topViewController as! OvenComparison
        oc.setArrays(isProperty, vals: arr)
    
    }

	override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isProperty {
			return properties.count
		} else {
			return ovens.count
		}
	}

	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if (isProperty) {
			let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

			let label = cell.textLabel!
			label.text = properties[indexPath.row] as String

			if indexPath.row < tempPropertiesChecked.count && tempPropertiesChecked[indexPath.row] {
				cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
			} else {
				cell.accessoryType = UITableViewCellAccessoryType.None
			}

			return cell
		} else {
			let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

			let label = cell.textLabel!
			label.text = ovens[indexPath.row] as String

			if indexPath.row < tempOvensChecked.count && tempOvensChecked[indexPath.row] {
				cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
			} else {
				cell.accessoryType = UITableViewCellAccessoryType.None
			}

			return cell
		}
	}

	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if isProperty && indexPath.row < tempPropertiesChecked.count {
			tempPropertiesChecked[indexPath.row] = !tempPropertiesChecked[indexPath.row]
		} else if indexPath.row < tempOvensChecked.count {
			tempOvensChecked[indexPath.row] = !tempOvensChecked[indexPath.row]
		}

		self.tableView.reloadData()
	}
}