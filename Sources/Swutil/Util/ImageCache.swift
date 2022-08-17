//
//  ImageCache.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//

import UIKit

/// `ImageCache` to handle image caching, avoiding the need to download previous images again.
/// It's possible to use a `shared` instance or to create a new one.
public final class ImageCache: Cachable {
    public static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private lazy var queue = DispatchQueue(label: String(describing: Self.self),
                                           attributes: .concurrent)

    public init() { }

    func object(forKey key: NSString, completion: @escaping (UIImage?) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            completion(self?.cache.object(forKey: key))
        }
    }

    func setObject(_ obj: UIImage, forKey key: NSString) {
        queue.async(flags: .barrier) { [weak self] in
            self?.cache.setObject(obj, forKey: key)
        }
    }
}
