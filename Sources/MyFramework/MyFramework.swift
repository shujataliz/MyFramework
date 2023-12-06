// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class MyFramework {
    
    static let pvtPasteBoard = UIPasteboard.withUniqueName()
    
    static let shared = MyFramework()
    
    var originalPasteMethod: Method?
    var swizPasteMethod: Method?
    
    var origPasteMethodIMP: IMP?
    var swizPasteMethodIMP: IMP?
    
    
//    public static func disableCopyPasteSwizzle() {
////        shared.swizzleUIPasteboardGeneral()
//    }
    
    public static func disableCopyPasteSwizzleEnterprise(app: UIApplicationDelegate) {
        shared.configureEnterprise(app)
        shared.swizzleUIPasteboardGeneral2()
    }
    
    func configureEnterprise(_ app: UIApplicationDelegate) {
        originalPasteMethod = class_getClassMethod(UIPasteboard.self, #selector(getter: UIPasteboard.general))
        swizPasteMethod = class_getInstanceMethod(object_getClass(app), #selector(privatePasteboard))
        
        if let originalPasteMethodResult = originalPasteMethod, let swizPasteResult = swizPasteMethod {
            origPasteMethodIMP = method_getImplementation(originalPasteMethodResult)
            swizPasteMethodIMP = method_getImplementation(swizPasteResult)
        }
    }
    
    public static func disableCopyPaste() {
        shared.appMovedToBackground()
//        if let shared = shared {
//            
//        }
//        NotificationCenter.default.addObserver(
//            shared!,
//            selector: #selector(shared.appMovedToBackground),
//            name: UIApplication.willResignActiveNotification,
//            object: nil
//        )
    }
    
    func swizzleUIPasteboardGeneral2() {
        if let originalMethod = originalPasteMethod,
           let swizzleMethod = swizPasteMethod,
           let originalMetodIMP = origPasteMethodIMP,
           let swizMethodIMP = swizPasteMethodIMP {
            method_setImplementation(originalMethod, originalMetodIMP)
            method_setImplementation(swizzleMethod, swizMethodIMP)
            
            method_exchangeImplementations(originalMethod, swizzleMethod)
        }
    }
    
//    func swizzleUIPasteboardGeneral() {
//       let aClass: AnyClass! = object_getClass(UIPasteboard.general)
//       let targetClass: AnyClass! = object_getClass(self)
//
//       let originalMethod = class_getClassMethod(aClass, #selector(getter: UIPasteboard.general))
//       let swizzledMethod = class_getInstanceMethod(targetClass, #selector(privatePasteboard))
//
//       if let originalMethod, let swizzledMethod {
//           method_exchangeImplementations(originalMethod, swizzledMethod)
//       }
//    }
    
    @objc
    func privatePasteboard() -> UIPasteboard {
        return MyFramework.pvtPasteBoard
    }
    
    @objc
    func appMovedToBackground() {
        UIPasteboard.general.string = ""
    }
}

//extension UIPasteboard {
//    @_dynamicReplacement(for: generalPasteboard)
//    static var privatePasteboard: UIPasteboard {
//        return MyFramework.shared.pvtPasteBoard
//    }
//}


class MyFrameworkTXT: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }

        return super.canPerformAction(action, withSender: sender)
        //return false
    }
}

//
//extension UITextView {
//    
//    
//}
