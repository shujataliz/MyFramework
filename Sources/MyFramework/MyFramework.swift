// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

//this code if restrict all copy paste without condition in app level
//extension UIPasteboard {
//    @_dynamicReplacement(for: generalPasteboard)
//    static var privatePasteboard: UIPasteboard {
//        return MyFrameClass.pvtPasteBoard
//    }
//
//}


public class MyFramework: NSObject {
    
    static let pvtPasteBoard = UIPasteboard.withUniqueName()
    static let shared = MyFramework()
    
    public static func disableCopyPasteSwizzleEnterprise() {
        
//        NotificationCenter.default.addObserver(
//            shared,
//            selector: #selector(shared.appMovedToBackground),
//            name: UIApplication.willResignActiveNotification,
//            object: nil
//        )

        let aClass: AnyClass! = object_getClass(UIPasteboard.general)
        let targetClass: AnyClass! = object_getClass(shared)

        let originalMethod = class_getClassMethod(aClass, #selector(getter: UIPasteboard.general))
        let swizzledMethod = class_getInstanceMethod(targetClass, #selector(shared.privatePasteboard))

        if let originalMethod, let swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    @objc
    func privatePasteboard() -> UIPasteboard {
        return MyFramework.pvtPasteBoard
    }

//    @objc
//    func appMovedToBackground() {
//        UIPasteboard.general.string = ""
//    }
}

