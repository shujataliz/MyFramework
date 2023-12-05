// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class MyFramework {
    
    var pvtPasteBoard = UIPasteboard.withUniqueName()
    
    static let shared = MyFramework()
    
    public static func disableCopyPasteSwizzle() {
        shared.swizzleUIPasteboardGeneral()
    }
    
    public static func disableCopyPaste() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(shared.appMovedToBackground),
            name: UIApplication.willResignActiveNotification,
            object: nil
        )
    }
    
    
    
    func swizzleUIPasteboardGeneral() {
       let aClass: AnyClass! = object_getClass(UIPasteboard.general)
       let targetClass: AnyClass! = object_getClass(self)

       let originalMethod = class_getClassMethod(aClass, #selector(getter: UIPasteboard.general))
       let swizzledMethod = class_getInstanceMethod(targetClass, #selector(privatePasteboard))

       if let originalMethod, let swizzledMethod {
           method_exchangeImplementations(originalMethod, swizzledMethod)
       }
    }
    
    @objc
    func privatePasteboard() -> UIPasteboard {
            return pvtPasteBoard
    }
    
    @objc
    func appMovedToBackground() {
        UIPasteboard.general.string = ""
    }
}


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
