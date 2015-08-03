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
    
    @IBOutlet weak var ovenModelNameTable: UIWebView!
    
	public func setArrays(isProperties: Bool, vals: Array<Bool>) {
		if isProperties {
			propertiesShowing = vals
		} else {
			ovensShowing = vals
		}
	}
    
    override public func viewDidAppear(animated: Bool) {
        self.refreshData()
    }
    
    @IBAction func stoppedLoading() {
        
    }
    
    public func refreshData() {
        let style = "<style>.oven { color: #DC291E; } .prop { color: #002663; } table { color: #000000; } td { padding-right: 15px; text-align: center; }</style>"
       
        var comparisonTable: String = style + "<table><tbody><tr>"
        
        if propertiesShowing[0] {
            comparisonTable += "<td class='prop'><strong>Belt Width</strong></td>"
        }
        if propertiesShowing[1] {
            comparisonTable += "<td class='prop'><strong>Chamber Length</strong></td>"
        }
        if propertiesShowing[2] {
            comparisonTable += "<td class='prop'><strong>Stacking</strong></td>"
        }
        if propertiesShowing[3] {
            comparisonTable += "<td class='prop'><strong>Gas or Electric</strong></td>"
        }
        if propertiesShowing[4] {
            comparisonTable += "<td class='prop'><strong>Electric Ventless</strong></td>"
        }
        if propertiesShowing[5] {
            comparisonTable += "<td class='prop'><strong>Has Half Pass Door</strong></td>"
        }
        
        comparisonTable += "</tr>"

        for var index = 0; index < ovens.count; index++ {
            if ovensShowing[index] {
                comparisonTable += "<tr>"
                
                if propertiesShowing[0] {
                    comparisonTable += "<td>" + belt_widths[index] + "</td>"
                }
                if propertiesShowing[1] {
                    comparisonTable += "<td>" + chamber_lengths[index] + "</td>"
                }
                if propertiesShowing[2] {
                    comparisonTable += "<td>" + stackings[index] + "</td>"
                }
                if propertiesShowing[3] {
                    comparisonTable += "<td>" + gasOrElectric[index] + "</td>"
                }
                if propertiesShowing[4] {
                    comparisonTable += "<td>" + electricVentless[index] + "</td>"
                }
                if propertiesShowing[5] {
                    comparisonTable += "<td>" + hasHalfPassDoor[index] + "</td>"
                }
                
                comparisonTable += "</tr>"
            }
        }
        comparisonTable += "</tbody></table>"
        
        var models = style + "<table><tbody><tr><td class='prop'><br /><strong>Oven<br />Model</strong><br /><br /></td></tr>"
        for var index = 0; index < ovensShowing.count; index++ {
            if ovensShowing[index] {
                models += "<tr><td class='oven'><strong>" + ovens[index] + "</strong></td></tr>"
            }
        }
        models += "</tbody></table>"
        
        ovenModelNameTable.stopLoading()
        ovenModelNameTable.loadHTMLString(models, baseURL: nil)
        
        webView.stopLoading()
        webView.loadHTMLString(comparisonTable, baseURL: nil)
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
}