//
//  PVActionInteractive.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 2/1/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import UIKit

public class PVActionInteractive: PVAction {
    @IBInspectable public var autoReverse : Bool = true
    @IBInspectable public var forwarding: Bool = true
    @IBInspectable public var speed : CGFloat = 1.0
    private var enable = false
    
    init(speed _sp: CGFloat) {
        speed = _sp
        super.init()
    }
    
    public override init() {
        super.init()
    }
    
    public override func start() {
        super.start()
        self.update(delay)
    }
    final func update(progress : CGFloat){
        self.step(pvClamp((max(progress - delay, 0) / (1 - delay)) * speed, minValue: 0, maxValue: 1))
    }
    
    public func step(fraction: CGFloat){
        //override by subclasses
    }
    public override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
}



