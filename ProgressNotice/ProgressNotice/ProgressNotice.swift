//
//  ProgressNotice.swift
//  ProgressNotice
//
//  Created by 安然 on 2018/1/9.
//  Copyright © 2018年 MacBook. All rights reserved.
//

import UIKit

enum ProgressNoticeStyle {
    case light   // default style, white ProgressNotice with black text, ProgressNotice background will be blurred
    case dark    // black HUD and white text, HUD background will be blurred
    case custom  // uses the fore- and background color properties
}

enum ProgressNoticeMaskType {
    case none     // default mask type, allow user interactions while HUD is displayed
    case clear    // don't allow user interactions with background objects
    case black    // don't allow user interactions with background objects and dim the UI in the back of the HUD (as seen in iOS 7 and above)
    case gradient // don't allow user interactions with background objects and dim the UI with a a-la UIAlertView background gradient (as seen in iOS 6
    case custom   // custom indefinite
}

enum ProgressNoticeAnimationType {
    case flat     // default animation type, custom flat animation (indefinite animated ring)
    case native   // iOS native UIActivityIndicatorView
}

typealias ProgressNoticeShowCompletion = ()->Void
typealias ProgressNoticeDismissCompletion = ()->Void

class ProgressNotice: UIView {
    
    // MARK: - notification
    static let ProgressNoticeDidReceiveTouchEventNotification = "ProgressNoticeDidReceiveTouchEventNotification"
    static let ProgressNoticeDidTouchDownInsideNotification = "ProgressNoticeDidTouchDownInsideNotification"
    static let ProgressNoticeWillDisappearNotification = "ProgressNoticeWillDisappearNotification"
    static let ProgressNoticeDidDisappearNotification = "ProgressNoticeDidDisappearNotification"
    static let ProgressNoticeWillAppearNotification = "ProgressNoticeWillAppearNotification"
    static let ProgressNoticeDidAppearNotification = "ProgressNoticeDidAppearNotification"
    static let ProgressNoticeStatusUserInfoKey = "ProgressNoticeStatusUserInfoKey"

    // MARK: - constant
    static let ProgressNoticeParallaxDepthPoints = 10.0
    static let ProgressNoticeUndefinedProgress = -1
    static let ProgressNoticeDefaultAnimationDuration = 0.15
    static let ProgressNoticeVerticalSpacing = 12.0
    static let ProgressNoticeHorizontalSpacing = 12.0
    static let ProgressNoticeLabelSpacing = 8.0

    


}


// MARK: - Show Methods
extension ProgressNotice {
    
    class func show() {
    
    }
    
    class func show(_ status: String ) {
        
    }
    
    class func show(_ status: String, maskType: ProgressNoticeMaskType) {
        
    }
    
    class func show(_ progress: Float) {
        
    }

}
