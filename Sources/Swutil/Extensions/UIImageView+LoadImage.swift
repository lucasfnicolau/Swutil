//
//  UIImageView+LoadImage.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import UIKit

/// ImageCache to handle image caching, avoiding the need to download previous images again.
/// It's possible to use a shared instance or to create a new one.
public class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private lazy var queue = DispatchQueue(label: String(describing: Self.self),
                                           attributes: .concurrent)

    func object(forKey key: NSString) -> UIImage? {
        queue.sync(flags: .barrier) { [weak self] in
            return self?.cache.object(forKey: key)
        }
    }

    func setObject(_ obj: UIImage, forKey key: NSString) {
        queue.async(flags: .barrier) { [weak self] in
            self?.cache.setObject(obj, forKey: key)
        }
    }
}

// Extension to help loading images from the internet.
extension UIImageView {

    struct FallbackImage {
        public let image: UIImage?
        public let tintColor: UIColor

        public init(image: UIImage? = SharedAssets.Image.defaultPlaceholder,
                    tintColor: UIColor = .systemGray) {
            self.image = image
            self.tintColor = tintColor
        }
    }

    /// Load an image from an URL address (String) and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - urlAddress: The desired URL address (String).
    ///   - fallbackImage: The fallback image to be used if the desired image is not downloaded.
    func loadImage(from urlAddress: String, fallbackImage: FallbackImage = .init()) {
        guard let url = URL(string: urlAddress) else {
            setFallbackImage(fallbackImage)
            return
        }
        self.loadImage(from: url, fallbackImage: fallbackImage)
    }

    /// Load an image from an URL and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - url: The desired URL.
    ///   - fallbackType: The fallback image to be used if the desired image is not downloaded.
    func loadImage(from url: URL?, fallbackImage: FallbackImage = .init()) {
        guard let url = url else {
            self.setFallbackImage(fallbackImage)
            return
        }

        if let cachedImage = ImageCache.shared.object(forKey: NSString(string: url.absoluteString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }

        let activityIndicatorView = build(UIActivityIndicatorView()) {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        activityIndicatorView.constraintCenter(to: self)

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    activityIndicatorView.removeFromSuperview()
                    self?.setFallbackImage(fallbackImage)
                }
                return
            }
            DispatchQueue.main.async {
                activityIndicatorView.removeFromSuperview()
                if let image = UIImage(data: data) {
                    self?.image = image
                    ImageCache.shared.setObject(image, forKey: NSString(string: url.absoluteString))
                } else {
                    self?.setFallbackImage(fallbackImage)
                }
            }
        }.resume()
    }

    private func setFallbackImage(_ fallBackImage: FallbackImage) {
        DispatchQueue.main.async {
            self.image = fallBackImage.image
            self.tintColor = fallBackImage.tintColor
        }
    }
}
