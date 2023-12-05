// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class MyFramework {
    
    public init() {
        
    }
    
    public func enableCopyPaste() {
        
    }
}


class MyFrameworkTXT: UITextField {
    
}


extension UITextView {
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }

        return super.canPerformAction(action, withSender: sender)
        //return false
    }
}
