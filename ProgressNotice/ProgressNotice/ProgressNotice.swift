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
    
    class var sharedView: ProgressNotice {
        struct Static {
            static let instance: ProgressNotice = ProgressNotice(frame: CGRect.zero)
        }
        return Static.instance
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isInitializing = true
        isUserInteractionEnabled = false
        activityCount = 0
        
        backgroundView?.alpha = 0.0
        imageView?.alpha = 0.0
        statusLabel?.alpha = 0.0
        indefiniteAnimatedView?.alpha = 0.0
        ringView?.alpha = 0
        backgroundRingView?.alpha = 0
        
        backgroundColor = UIColor.white
        foregroundColor = UIColor.black
        backgroundLayerColor = UIColor(white: 0, alpha: 0.4)
        
        // Accessibility support
        accessibilityIdentifier = "ProgressNotice"
        isAccessibilityElement = true
        isInitializing = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateHUDFrame() {
        var isImageViewHidden: Bool = false
        if let isHidden = imageView?.isHidden, isHidden == true {
            isImageViewHidden = true
        }
        let isImageUsed = (imageView?.image != nil) && !(isImageViewHidden)
        let isProgressUsed = isImageViewHidden
        
        let labelRect: CGRect = CGRect.zero
        let labelHeight: CGFloat = 0
        let labelWidth: CGFloat = 0
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    // MARK: - property
    
    var defaultStyle: ProgressNoticeStyle = .dark
    
    var defaultMaskType: ProgressNoticeMaskType = .none
    
    var defaultAnimationType: ProgressNoticeAnimationType = .flat
    
    var containerView: UIView?
    
    var minimumSize: CGSize = CGSize.zero
    
    var ringThickness: CGFloat = 2
    
    var ringRadius: CGFloat = 18
    
    var ringNoTextRadius: CGFloat = 24
    
    var cornerRadius: CGFloat = 14
    
    var font: UIFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    
    var backgroundColor1: UIColor = UIColor.white
    
    var foregroundColor: UIColor = UIColor.black
    
    var backgroundLayerColor: UIColor = UIColor.init(white: 0, alpha: 0.4)
    
    var imageViewSize: CGSize = CGSize(width: 28, height: 28)
    
    var isShouldTintImages: Bool = true
    
    lazy var infoImage: UIImage = {
        let bundle = Bundle(for: IndefiniteAnimatedView.self)
        
        guard let url = bundle.url(forResource: "ProgressNotice",
                                   withExtension: "bundle") else {
             return UIImage()
        }
        
        let imageBundle = Bundle(url: url)
        
        guard let path = imageBundle?.path(forResource: "info",
                                           ofType: "png") else{
            return UIImage()
        }
        
        guard let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        
        return image
    }()
    
    lazy var successImage: UIImage = {
        let bundle = Bundle(for: IndefiniteAnimatedView.self)
        
        guard let url = bundle.url(forResource: "ProgressNotice",
                                   withExtension: "bundle") else {
                                    return UIImage()
        }
        
        let imageBundle = Bundle(url: url)
        
        guard let path = imageBundle?.path(forResource: "success",
                                           ofType: "png") else{
                                            return UIImage()
        }
        
        guard let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        
        return image
    }()
    
    lazy var errorImage: UIImage = {
        let bundle = Bundle(for: IndefiniteAnimatedView.self)
        
        guard let url = bundle.url(forResource: "ProgressNotice",
                                   withExtension: "bundle") else {
                                    return UIImage()
        }
        
        let imageBundle = Bundle(url: url)
        
        guard let path = imageBundle?.path(forResource: "error",
                                           ofType: "png") else{
                                            return UIImage()
        }
        
        guard let image = UIImage(contentsOfFile: path) else {
            return UIImage()
        }
        
        return image
    }()
    
    var viewForExtension: UIView?
    
    var graceTimeInterval: TimeInterval = 0
    
    var minimumDismissTimeInterval: TimeInterval = 5
    
    var maximumDismissTimeInterval: TimeInterval = TimeInterval.greatestFiniteMagnitude
    
    var offsetFromCenter: UIOffset = UIOffset.zero
    
    var fadeInAnimationDuration: TimeInterval = 0.15
    
    var fadeOutAnimationDuration: TimeInterval = 0.15
    
    var maxSupportedWindowLevel: UIWindowLevel = UIWindowLevelNormal
    
    var isHapticsEnabled: Bool = false
    
    
    fileprivate var graceTimer: Timer?
    
    fileprivate var fadeOutTimer: Timer?
    
    fileprivate var controlView: UIControl?
    
    fileprivate var backgroundView: UIView?
    
    fileprivate var backgroundRadialGradientLayer: RadialGradientLayer?
    
    fileprivate var hudView: UIView?
    
    fileprivate var statusLabel: UILabel?
    
    fileprivate var imageView: UIImageView?
    
    fileprivate var indefiniteAnimatedView: UIView?
    
    fileprivate var ringView: ProgressAnimatedView?
    
    fileprivate var backgroundRingView: ProgressAnimatedView?
    
    fileprivate var progress: CGFloat = 0
    
    fileprivate var activityCount: UInt64 = 0
    
    fileprivate var visibleKeyboardHeight: CGFloat = 0
    
    fileprivate var frontWindow: UIWindow?
    
    fileprivate var isInitializing: Bool = false

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
