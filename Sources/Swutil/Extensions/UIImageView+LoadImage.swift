//
//  UIImageView+LoadImage.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import UIKit

// Extension to help loading images from the internet.
public extension UIImageView {

    struct FallbackImage {
        public let image: UIImage?
        public let tintColor: UIColor

        public init(image: UIImage? = SharedAssets.Images.defaultPlaceholder,
                    tintColor: UIColor = .systemGray) {
            self.image = image
            self.tintColor = tintColor
        }
    }

    /// Load an image from an URL address (String) and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - urlAddress: The desired URL address (String).
    ///   - fallbackImage: The fallback image to be used if the desired image is not downloaded.
    ///   - tasksManager: The manager object responsible for handling the active `URLSessionDataTask`'s.
    ///   - cache: The cache object used to store downloaded images that will be reused later.
    func loadImage(from urlAddress: String,
                   fallbackImage: FallbackImage = .init(),
                   tasksManager: URLSessionDataTaskHandler = URLSessionDataTasksManager.shared,
                   cache: Cacheable = ImageCache.shared)
    {
        tasksManager.cancelTask(for: hash)
        guard let url = URL(string: urlAddress) else {
            setFallbackImage(fallbackImage)
            return
        }
        loadImage(from: url, fallbackImage: fallbackImage, cache: cache)
    }

    /// Load an image from an URL and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - url: The desired URL.
    ///   - fallbackType: The fallback image to be used if the desired image is not downloaded.
    ///   - tasksManager: The manager object responsible for handling the active `URLSessionDataTask`'s.
    ///   - cache: The cache object used to store downloaded images that will be reused later.
    func loadImage(from url: URL?,
                   fallbackImage: FallbackImage = .init(),
                   tasksManager: URLSessionDataTaskHandler = URLSessionDataTasksManager.shared,
                   cache: Cacheable)
    {
        tasksManager.cancelTask(for: hash)
        guard let url = url else {
            setFallbackImage(fallbackImage)
            return
        }

        cache.object(forKey: NSString(string: url.absoluteString)) { [weak self] cachedImage in
            if let cachedImage = cachedImage {
                self?.setImage(cachedImage)
                return
            }

            self?.startLoading { [weak self] activityIndicatorView in
                let task = URLSession.shared.dataTask(with: url) { [weak self, weak activityIndicatorView] data, _, error in

                    tasksManager.cancelTask(for: self?.hash ?? .zero)

                    guard let data = data, error == nil else {
                        self?.stopLoading(&activityIndicatorView)
                        self?.setFallbackImage(fallbackImage)
                        return
                    }

                    self?.stopLoading(&activityIndicatorView)
                    if let image = UIImage(data: data) {
                        self?.setImage(image)
                        cache.setObject(image, forKey: NSString(string: url.absoluteString))
                    } else {
                        self?.setFallbackImage(fallbackImage)
                    }
                }
                tasksManager.addTask(task, for: self?.hash ?? .zero)
                task.resume()
            }
        }
    }

    private func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.alpha = .zero
            UIView.animate(withDuration: .zero) {
                self.image = image
                self.alpha = 1
            }
        }
    }

    private func startLoading(completion: @escaping (inout UIActivityIndicatorView?) -> Void) {
        DispatchQueue.main.async {
            self.image = nil
            var activityIndicatorView: UIActivityIndicatorView?
            activityIndicatorView = build(UIActivityIndicatorView()) {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }

            if let activityIndicatorView = activityIndicatorView {
                self.addSubview(activityIndicatorView)
                activityIndicatorView.startAnimating()
                activityIndicatorView.center(to: self)
            }

            completion(&activityIndicatorView)
        }
    }

    private func stopLoading(_ spinner: inout UIActivityIndicatorView?) {
        DispatchQueue.main.async { [weak spinner] in
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }

    private func setFallbackImage(_ fallBackImage: FallbackImage) {
        DispatchQueue.main.async {
            self.image = fallBackImage.image
            self.tintColor = fallBackImage.tintColor
        }
    }
}
