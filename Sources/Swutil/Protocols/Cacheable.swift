//
//  Cacheable.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//

import UIKit

public protocol Cacheable {
    func object(forKey key: NSString, completion: @escaping (UIImage?) -> Void)
    func setObject(_ obj: UIImage, forKey key: NSString)
}
