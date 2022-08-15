//
//  GenericBuilder.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

public func build<T>(_ instance: T, builderClosure: (T) -> Void) -> T {
    builderClosure(instance)
    return instance
}
