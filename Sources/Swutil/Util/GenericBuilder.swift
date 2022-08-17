//
//  GenericBuilder.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

/// Generic builder function to make a little bit easier, clean and standarized the creation of any given type.
///
///     let label = build(UILabel()) {
///         $0.translatesAutoresizingMaskIntoConstraints = false
///         $0.numberOfLines = .zero
///         // ...
///     }
public func build<T>(_ instance: T, builderClosure: (T) -> Void) -> T {
    builderClosure(instance)
    return instance
}
