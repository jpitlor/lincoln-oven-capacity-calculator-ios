//
//  OvenComparisonModelDelegate.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 8/2/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class OvenComparisonModelDelegate: UITableViewController {
    var ovens: Array<String> = ["2500", "1100", "1400", "1600", "3240", "3255", "3270"]
    var ovensShowing: Array<Bool> = [true, true, true, true, true, true, true]
    var propName: String = "Models"
    
    override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for shown in ovensShowing {
            if shown {
                count++
            }
        }
        return count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("oven", forIndexPath: indexPath) 
        
        if indexPath.row == 0 {
            cell.textLabel!.text = self.propName
        } else {
            cell.textLabel!.text = ovens[getNthObject(indexPath.row)] as String
        }
        
        return cell
    }
    
    private func getNthObject(which: Int) -> Int {
        var n = which
        
        for var index = 0; index < ovensShowing.count; index++ {
            if ovensShowing[index] {
                n--
            }
            if n == 0 {
                return index
            }
        }
        return 0
    }
    
    public func get() -> [Bool] {
        return ovensShowing
    }
    
    public func set(arr: [Bool]) {
        ovensShowing = arr
    }
}