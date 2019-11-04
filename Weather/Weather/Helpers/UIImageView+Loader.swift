//
//  UIImageView+Loader.swift
//  Weather
//
//  Created by Narine Balasanyan on 11/3/19.
//  Copyright © 2019 Fifth. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func image(withURL url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
