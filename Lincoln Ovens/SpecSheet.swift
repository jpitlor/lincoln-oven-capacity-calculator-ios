//
//  SpecSheet.swift
//  Lincoln Ovens
//
//  Created by Jordan Pitlor on 7/28/15.
//  Copyright (c) 2015 Manitowoc Foodservice. All rights reserved.
//

import Foundation
import UIKit

public class SpecSheet: UIViewController {
	@IBOutlet weak var webView: UIWebView!
	var fileName: String = ""
    var model: String = ""

    override public func viewWillAppear(animated: Bool) {
		loadSpecSheet()
        self.navigationItem.title = model + " Spec Sheet"
	}

	public func loadSpecSheet() {
		if let pdf = NSBundle.mainBundle().URLForResource("pdfs.bundle/" + self.fileName, withExtension: "pdf", subdirectory: nil, localization: nil) {
			let req = NSURLRequest(URL: pdf)
			webView.loadRequest(req)
		}
	}

    public func setSpecSheet(fileName: String, model: String) {
		self.fileName = fileName
	}
}
