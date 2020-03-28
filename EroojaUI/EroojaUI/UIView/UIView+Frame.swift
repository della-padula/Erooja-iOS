//
//  UIView+Frame.swift
//  erooja
//
//  Created by denny.k on 2020/03/26.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import Foundation

public extension UIView {
    
    @objc var x: CGFloat {
        get {
            return left
        }
        set {
            left = newValue
        }
    }
    
    @objc var y: CGFloat {
        get {
            return top
        }
        set {
            top = newValue
        }
    }
    
    @objc var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var newFrame: CGRect = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    
    @objc var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var newFrame: CGRect = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    @objc var right: CGFloat {
        get {
            return frame.maxX
        }
        set {
            var newFrame: CGRect = frame
            newFrame.origin.x = newValue - frame.size.width
            frame = newFrame
        }
    }
    
    @objc var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            var newFrame: CGRect = frame
            newFrame.origin.y = newValue - frame.size.height
            frame = newFrame
        }
    }
    
    @objc var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            var newFrame: CGRect = frame
            newFrame.origin = newValue
            frame = newFrame
        }
    }
    
    @objc var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center = CGPoint(x: newValue, y: center.y)
        }
    }
    
    @objc var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center = CGPoint(x: center.x, y: newValue)
        }
    }
    
    @objc var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var newFrame: CGRect = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    @objc var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var newFrame: CGRect = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    
    @objc var size: CGSize {
        get {
            return frame.size
        }
        set {
            var newFrame: CGRect = frame
            newFrame.size = newValue
            frame = newFrame
        }
    }
}
