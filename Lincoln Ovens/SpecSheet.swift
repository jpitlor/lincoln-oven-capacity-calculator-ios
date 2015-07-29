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

	override public func viewDidLoad() {
		super.viewDidLoad()
		loadSpecSheet()
	}

	public func loadSpecSheet() {
		if let pdf = NSBundle.mainBundle().URLForResource("pdfs.bundle/" + self.fileName, withExtension: "pdf", subdirectory: nil, localization: nil) {
			let req = NSURLRequest(URL: pdf)
			webView.loadRequest(req)
		}
	}

	public func setSpecSheet(fileName: String) {
		self.fileName = fileName
	}
}
