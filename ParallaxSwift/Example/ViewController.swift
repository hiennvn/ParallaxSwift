//
//  ViewController.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 10/27/15.
//  Copyright © 2015 Tom Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        (self.view as? ParallaxView)?.update()
    }

}

