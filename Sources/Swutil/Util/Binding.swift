//
//  Binding.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import Foundation

/// Generic struct to handle binding behavior for any type.
///
///     // Instantiate a new Binding variable
///     var names: Binding<[String]> = Binding([])
///
///     // Assign a value to a binding variable (i.e.: when receiving an API response)
///     names.value = ["Lucas", "Leonardo", "Eduardo", "Claudia"]
///
///     // Binding a closure to be executed when the variable value changes
///     names.onValueChange = { newValue in
///         // Do something...
///     }
public final class Binding<T> {
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

    public func onValueChange(_ callback: @escaping BindingCallback) {
        self.callback = callback
    }
}
