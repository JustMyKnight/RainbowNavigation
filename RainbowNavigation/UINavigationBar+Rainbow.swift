//
//  UINavigationBar+Rainbow.swift
//  Pods
//
//  Created by Danis on 15/11/25.
//
//

import Foundation

private var kRainbowAssociatedKey = "kRainbowAssociatedKey"

public class Rainbow: NSObject {
    var navigationBar: UINavigationBar
    
    init(navigationBar: UINavigationBar) {
        self.navigationBar = navigationBar
        
        super.init()
    }
    
    fileprivate var navigationView: UIView?
    fileprivate var statusBarView: UIView?
    
    public var backgroundColor: UIColor? {
        get {
            return navigationView?.backgroundColor
        }
        set {
            if navigationView == nil {
                navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationBar.shadowImage = UIImage()
                var height = navigationBar.bounds.height
                if let safeAreaTop = UIApplication.shared.keyWindow?.safeAreaInsets.top {
                    height = safeAreaTop + height
                }
                let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
                navigationView = UIView(frame: CGRect(x: 0, y: -statusBarHeight, width: navigationBar.bounds.width, height: height))
                navigationView?.isUserInteractionEnabled = false
                guard let subview = navigationBar.subviews.first else { return }
                navigationView?.translatesAutoresizingMaskIntoConstraints = false
                subview.insertSubview(navigationView!, at: 0)
                NSLayoutConstraint(item: navigationView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: subview,
                                   attribute: .top,
                                   multiplier: 1.0,
                                   constant: 0).isActive = true
                NSLayoutConstraint(item: navigationView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: subview,
                                   attribute: .bottom,
                                   multiplier: 1.0,
                                   constant: 0).isActive = true
                NSLayoutConstraint(item: navigationView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: subview,
                                   attribute: .leading,
                                   multiplier: 1.0,
                                   constant: 0).isActive = true
                NSLayoutConstraint(item: navigationView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: subview,
                                   attribute: .trailing,
                                   multiplier: 1.0,
                                   constant: 0).isActive = true
            }
            navigationView!.backgroundColor = newValue
        }
    }
    
    public var statusBarColor: UIColor? {
        get {
            return statusBarView?.backgroundColor
        }
        set {
            if statusBarView == nil {
                statusBarView = UIView(frame: CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: navigationBar.bounds.width, height: UIApplication.shared.statusBarFrame.height))
                statusBarView?.isUserInteractionEnabled = false
                statusBarView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                guard let subview = navigationBar.subviews.first else { return }
                subview.insertSubview(navigationView!, at: 0)
            }
            statusBarView?.backgroundColor = newValue
        }
    }
    
    public var statusBarHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    public func clear() {
        navigationBar.setBackgroundImage(nil, for: .default)
        navigationBar.shadowImage = nil
        
        navigationView?.removeFromSuperview()
        navigationView = nil
        
        statusBarView?.removeFromSuperview()
        statusBarView = nil
    }
}

extension UINavigationBar {
    public var rb: Rainbow {
        get {
            if let rainbow = objc_getAssociatedObject(self, &kRainbowAssociatedKey) as? Rainbow {
                return rainbow
            }
            let rainbow = Rainbow(navigationBar: self)
            objc_setAssociatedObject(self, &kRainbowAssociatedKey, rainbow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return rainbow
        }
    }
}
