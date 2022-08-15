//
//  Binding.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import Foundation

public class Binding<T> {
    public typealias BindingCallback = (T) -> Void

    private var callback: BindingCallback?

    public var value: T {
        didSet {
            callback?(value)
        }
    }

    public init(_ value: T) {
        self.value = value
    }

    public func bind(_ callback: @escaping BindingCallback) {
        self.callback = callback
    }
}
