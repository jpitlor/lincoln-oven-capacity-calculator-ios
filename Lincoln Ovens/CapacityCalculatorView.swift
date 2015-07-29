//
//  CapacityCalculatorView.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/28/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class CapacityCalculatorView: UIViewController {
	@IBOutlet weak var beltWidth: UITextField!
	@IBOutlet weak var chamberLength: UITextField!
	@IBOutlet weak var bakeTime: UITextField!
	@IBOutlet weak var panDiameter: UITextField!
	@IBOutlet weak var panLength: UITextField!
	@IBOutlet weak var panWidth: UITextField!
    
    @IBAction func calculateButtonClicked(sender: UIButton) {
		if errorCheck() {

		} else {
			let popup: UIAlertController = UIAlertController(title: "Inputs Missing", message: "Please fill out all of the inputs, then try calculating the capacity again", preferredStyle: .Alert)
			let OKAction = UIAlertAction(title: "OK", style: .Default) {
				(action) in
				// Do nothing
			}
			popup.addAction(OKAction)
			self.presentViewController(popup, animated: true, completion: nil)
		}
	}

	private func errorCheck() -> Bool {
		return false
	}

	private func dismiss() {

    }
}