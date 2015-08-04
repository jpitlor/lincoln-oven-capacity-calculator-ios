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
        self.sourceViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
