//
//  PVActionFadeBy.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionFadeBy : PVActionInteractive {
    var _start: Float = 1
    var _delta: Float = 0
    @IBInspectable public var startAlpha: Float = 1
    @IBInspectable public var endAlpha: Float = 0
    
    public override func setups() {
        super.setups()
        _start = startAlpha
        _delta = endAlpha
    }
    
    public override func step(fraction: CGFloat) {
        target.layer.opacity = _start + _delta * Float(fraction)
    }
}
