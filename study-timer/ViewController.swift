//
//  ViewController.swift
//  study-timer
//
//  Created by HeeJu Kim on 5/26/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let contentView = ContentView()
        let hostingController = UIHostingController(rootView: contentView)
                
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
    }


}

