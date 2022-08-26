//
//  UIStackView+AddArrangedSubviews.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
}
