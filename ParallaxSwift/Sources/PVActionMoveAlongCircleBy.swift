//
//  PVActionMoveAlongCircleBy.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionMoveAlongCircleBy : PVActionInteractive {
    var _center: CGPoint!
    var _delta : CGFloat!
    var _start : CGFloat!
    
    @IBInspectable public var center : CGPoint = pvp(0, y: 0)
    @IBInspectable public var radius : CGFloat = 0
    @IBInspectable public var startAngle: CGFloat = 0
    @IBInspectable public var endAngle: CGFloat = 0
    @IBInspectable public var centerRelative: Bool = false
    
    public override func setups() {
        super.setups()
        setupInputs()
        _center = center
        if let size = target.superview?.bounds.size {
            if centerRelative {
                _center = pvp(_center.x * size.width, y: _center.y * size.height)
            }
        }
    }
    
    func setupInputs(){
        _start = startAngle.radianValue
        _delta = endAngle.radianValue
    }
    
    
    public override func step(fraction: CGFloat) {
        let angle = _start + _delta * fraction
        target.layer.position = _center + (pvp(cos(angle), y: -sin(angle)) * radius)
    }
}
