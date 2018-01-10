//
//  RadialGradientLayer.swift
//  ProgressNotice
//
//  Created by 安然 on 2018/1/8.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
    
    override func draw(in ctx: CGContext) {
        let locationsCount: Int = 2
        let locations: [CGFloat] = [0.0, 1.0]
        let colors: [CGFloat] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.75]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let gradient = CGGradient(colorSpace: colorSpace,
                                  colorComponents: colors,
                                  locations: locations,
                                  count: locationsCount) else { return }
        let radius: CGFloat = min(self.bounds.size.width,
                                  self.bounds.size.height)
        
        ctx.drawRadialGradient(gradient,
                               startCenter: gradientCenter,
                               startRadius: 0,
                               endCenter: gradientCenter,
                               endRadius: radius,
                               options: CGGradientDrawingOptions.drawsAfterEndLocation)
        
        
        
    }
    
    public var gradientCenter: CGPoint = CGPoint()

}
