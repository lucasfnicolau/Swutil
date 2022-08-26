//
//  UsesAutoLayout.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 25/08/22.
//
//  Source: https://www.avanderlee.com/swift/auto-layout-programmatically/
//

import UIKit

@propertyWrapper
public final class UsesAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
