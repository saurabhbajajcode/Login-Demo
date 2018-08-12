//
//  AppManager.swift
//  Login Demo
//
//  Created by Saurabh on 12/08/18.
//  Copyright © 2018 Saurabh. All rights reserved.
//

import UIKit

class AppManager: NSObject {

    static var collection: [String: Any] = {
        if let path = Bundle.main.path(forResource: "collection", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let jsonResult = jsonResult as? [String: Any] {
                    return jsonResult
                }
            } catch {

            }
        }
        return [:]
    }()
}

extension UIView {
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: 50, y: 120, width: self.frame.size.width - 100, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 3.5, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
