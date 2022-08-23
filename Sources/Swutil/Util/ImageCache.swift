//
//  ImageCache.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//

import UIKit

/// `ImageCache` to handle image caching, avoiding the need to download previous images again.
/// It's possible to use a `shared` instance or to create a new one.
public final class ImageCache: Cacheable {
    public static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private lazy var queue = DispatchQueue(label: UUID().uuidString, attributes: .concurrent)

    public init() { }

    public func object(forKey key: NSString, completion: @escaping (UIImage?) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            completion(self?.cache.object(forKey: key))
        }
    }

    public func setObject(_ obj: UIImage, forKey key: NSString) {
        queue.async(flags: .barrier) { [weak self] in
            self?.cache.setObject(obj, forKey: key)
        }
    }
}
