//
//  CustomTabbar.swift
//  MyToDoList
//
//  Created by Ezgi Karahan on 22.12.2023.
//

import UIKit

class CustomTabBar: UITabBar {
    override func draw(_ rect: CGRect) {
        // Tab Bar'ı yuvarlak yap
                self.layer.cornerRadius = self.bounds.height / 2
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
}
