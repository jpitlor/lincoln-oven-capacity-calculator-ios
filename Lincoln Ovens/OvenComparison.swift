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
	let chamber_lengths = ["20", "28", "40", "40", "40", "55", "70"]
	let stackings = ["Double", "Triple", "Double", "Triple", "Triple", "Triple", "Triple"]
	let gasOrElectric = ["Electric", "Both" , "Both" ,"Both" ,"Both", "Gas", "Gas"]
	let electricVentless = ["Yes", "Yes", "No", "No", "No", "No", "No"]
	let hasHalfPassDoor = ["No", "Yes", "Yes", "Yes", "Yes", "Yes", "Yes"]

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var ovenModelNameTable: UITableView!
    
	public func setArrays(isProperties: Bool, vals: Array<Bool>) {
		if isProperties {
			propertiesShowing = vals
		} else {
			ovensShowing = vals
            (ovenModelNameTable.delegate as! OvenComparisonModelDelegate).set(vals)
		}
	}
    
    override public func viewWillAppear(animated: Bool) {
        //ovensShowing = (ovenModelNameTable.delegate as! OvenComparisonModelDelegate).get()
        //ovenModelNameTable.reloadData()
        
        var html: String = "<table><tbody>"
        for var index = 0; index < ovens.count; index++ {
            if ovensShowing[index] {
                html += "<tr>"
                
                if propertiesShowing[0] {
                    html += "<td>" + belt_widths[index] + "</td>"
                }
                if propertiesShowing[1] {
                    html += "<td>" + chamber_lengths[index] + "</td>"
                }
                if propertiesShowing[2] {
                    html += "<td>" + stackings[index] + "</td>"
                }
                if propertiesShowing[3] {
                    html += "<td>" + gasOrElectric[index] + "</td>"
                }
                if propertiesShowing[4] {
                    html += "<td>" + electricVentless[index] + "</td>"
                }
                if propertiesShowing[5] {
                    html += "<td>" + hasHalfPassDoor[index] + "</td>"
                }
                
                html += "</tr>"
            }
        }
        html += "</tbody></table>"
        
        webView.loadHTMLString(html, baseURL: nil)
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
//        let o = OvenComparisonModelDelegate()
//        ovenModelNameTable.dataSource = o
//        ovenModelNameTable.delegate = o
    }
}