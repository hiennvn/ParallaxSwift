//
//  PVActionMoveTo.swift
//  ParallaxSwift
//
//  Created by Tom Nguyen on 4/19/16.
//  Copyright © 2016 Tom Nguyen. All rights reserved.
//

import Foundation
import UIKit

public class PVActionMoveTo : PVActionMoveBy {
    override func setupInputs() {
        _start = startPosition
        _delta = endPosition - startPosition
    }
}
