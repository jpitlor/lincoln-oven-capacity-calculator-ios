//
//  SaveSegue.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 8/3/15.
//  Copyright © 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class SaveSegue: UIStoryboardSegue {
    override public func perform() {
        let b = (self.sourceViewController as! ToggleOvensAndProperties).getBool()
        let a = (self.sourceViewController as! ToggleOvensAndProperties).get()
        
        ((self.destinationViewController as! UINavigationController).topViewController as! OvenComparison).setArrays(b, vals: a)
        self.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
