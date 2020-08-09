//
//  UIView+DisableAutorisizingMask.swift
//  PostsFeed
//
//  Created by Dima on 09.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

extension UIView {
    func disableAutoresizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
