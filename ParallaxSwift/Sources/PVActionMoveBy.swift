//
//  PVActionMoveBy.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionMoveBy : PVActionInteractive {
    var _start : CGPoint!
    var _delta : CGPoint!
    @IBInspectable public var startPosition : CGPoint = pvp(0, y: 0)
    @IBInspectable public var endPosition : CGPoint = pvp(0, y: 0)
    @IBInspectable public var isRelative : Bool = true
    
    override public func setups() {
        super.setups()
        setupInputs()
        if self.isRelative {
            if let size = target.superview?.bounds.size {
                _start = pvp(_start.x * size.width, y: _start.y * size.height)
                _delta = pvp(_delta.x * size.width, y: _delta.y * size.height)
            }
        }
    }
    
    func setupInputs(){
        _start = startPosition
        _delta = endPosition
    }
    
    override public func step(fraction: CGFloat) {
        target.layer.position = _start + (_delta * fraction)
    }
}
