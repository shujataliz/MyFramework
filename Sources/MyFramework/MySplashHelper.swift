//
//  File.swift
//  
//
//  Created by Shujat Ali on 08/12/2023.
//

import Foundation
import UIKit

//this class just show a splash screen when in background so in background cannot preview app.
public class MySplashHelper {
    
    weak var screen : UIView? = nil
    static let shared = MySplashHelper()
    
    public static func registerSplashScreenforBackground() {
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { _ in
            shared.blurScreen()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            shared.blurScreen()
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { _ in
            shared.removeBlurScreen()
        }
    }
    
    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        guard let vc = getTopViewController(), screen == nil else {
            return
        }
        screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        let label = UILabel()
        label.text = "Background activity detected"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.red
        screen?.addSubview(blurBackground)
        screen?.addSubview(label)
        blurBackground.frame = (screen?.frame)!
        vc.view.addSubview(screen!)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: vc.view.frame.width * 0.8).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.centerXAnchor.constraint(equalTo: blurBackground.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: blurBackground.centerYAnchor).isActive = true
        blurBackground.bringSubviewToFront(label)
        
    }

    func removeBlurScreen() {
        screen?.removeFromSuperview()
        screen = nil
    }
    
    func getTopViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            // topController should now be your topmost view controller
            return topController
        }
        return nil
    }
}
