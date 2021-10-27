//
//  UIImage+UIColor.swift
//  itunes-vip
//
//  Created by Utsav Patel on 17/10/21.
//

import UIKit

extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1) ) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.set()
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        self.init(data: image.pngData()!)!
    }
}
