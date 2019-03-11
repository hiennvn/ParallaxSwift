//
//  PVActionFadeTo.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation

public class PVActionFadeTo : PVActionFadeBy {
    public override func setups() {
        _start = startAlpha
        _delta = endAlpha - startAlpha
    }
}
