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
    func loadImage(from urlAddress: String, fallbackImage: FallbackImage = .init()) {
        guard let url = URL(string: urlAddress) else {
            setFallbackImage(fallbackImage)
            return
        }
        loadImage(from: url, fallbackImage: fallbackImage)
    }

    /// Load an image from an URL and show an activity indicator while the image is being downloaded.
    /// - Parameters:
    ///   - url: The desired URL.
    ///   - fallbackType: The fallback image to be used if the desired image is not downloaded.
    func loadImage(from url: URL?, fallbackImage: FallbackImage = .init()) {
        guard let url = url else {
            setFallbackImage(fallbackImage)
            return
        }

        ImageCache.shared.object(forKey: NSString(string: url.absoluteString)) { [weak self] cachedImage in
            if let cachedImage = cachedImage {
                self?.setImage(cachedImage)
                return
            }
        }

        startLoading { [weak self] activityIndicatorView in
            URLSession.shared.dataTask(with: url) { [weak self, weak activityIndicatorView] data, _, error in
                guard let data = data, error == nil else {
                    self?.stopLoading(&activityIndicatorView)
                    self?.setFallbackImage(fallbackImage)
                    return
                }

                self?.stopLoading(&activityIndicatorView)
                if let image = UIImage(data: data) {
                    self?.setImage(image)
                    ImageCache.shared.setObject(image, forKey: NSString(string: url.absoluteString))
                } else {
                    self?.setFallbackImage(fallbackImage)
                }
            }.resume()
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
