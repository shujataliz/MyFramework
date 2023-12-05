// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public class MyFramework {
    
    public init() {
        
    }
    
    public func enableCopyPaste() {
        
    }
}


extension UITextView {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}
