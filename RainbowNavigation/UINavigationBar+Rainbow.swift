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
                if #available(iOS 11, *) {
                    navigationView = UIView(frame: CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: navigationBar.bounds.width, height: navigationBar.bounds.height + UIApplication.shared.statusBarFrame.height))
                }
                else {
                    navigationView = UIView(frame: CGRect(x: 0, y: 0, width: navigationBar.bounds.width, height: navigationBar.bounds.height + UIApplication.shared.statusBarFrame.height))
                }
                navigationView?.isUserInteractionEnabled = false
                navigationView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                guard let subview = navigationBar.subviews.first else { return }
                subview.insertSubview(navigationView!, at: 0)
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
                if #available(iOS 11, *) {
                    guard let subview = navigationBar.subviews.first else { return }
                    subview.insertSubview(navigationView!, at: 0)
                } else {
                    navigationBar.insertSubview(navigationView!, at: 0)
                }
            }
            statusBarView?.backgroundColor = newValue
        }
    }
    
    public var statusBarHeight: CGFloat {
        get {
            return statusBarView?.frame.height ?? 0
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
