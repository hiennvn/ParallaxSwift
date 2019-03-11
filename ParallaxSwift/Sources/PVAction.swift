//
//  PVAction.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 1/22/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVAction : NSObject {
    @IBOutlet public weak var target : UIView!
    @IBInspectable public var pageIndex: Int = 0
    @IBInspectable public var delay: CGFloat = 0.0

    public override init() {
        super.init()
    }

    public func setups(){
        target?.hidden = true
    }
    
    public func start() {
        target?.hidden = false
    }
}

