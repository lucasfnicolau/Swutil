//
//  Cachable.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//

import Foundation

protocol Cachable {
    associatedtype T

    func object(forKey key: NSString, completion: @escaping (T?) -> Void)
    func setObject(_ obj: T, forKey key: NSString)
}
