//
//  UIView+Constraints.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import UIKit

public extension UIView {

    enum ConstraintDistance {
        case equalTo
        case lessThanOrEqualTo
        case greaterThanOrEqualTo
    }

    @discardableResult
    /// Constraint the current view topAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    func constraintTop(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            self.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            self.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    @discardableResult
    /// Constraint the current view leadingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    func constraintLeading(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            self.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            self.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            self.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    @discardableResult
    /// Constraint the current view trailingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    func constraintTrailing(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            self.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            self.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            self.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    @discardableResult
    /// Constraint the current view bottomAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    func constraintBottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            self.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            self.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            self.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    @discardableResult
    /// Constraint the current view centerY and centerX anchors with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    func constraintCenter(to view: UIView) -> Self {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view centerYAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintCenterY(to view: UIView, constant: CGFloat = .zero) -> Self {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the current view centerXAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    func constraintCenterX(to view: UIView, constant: CGFloat = .zero) -> Self {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
  /// Constraint all the four main anchors (top, leading, trailing and bottom) of the current view with the anchor received by paremeter.
  /// - Parameters:
  ///   - view: The view where the constraint should be applied to.
  ///   - usingSafeArea: Boolean controlling the use of the safe area when applying the constraints.
  ///   - constant: A custom constant to be used in the constraints.
    func constraint(to view: UIView, usingSafeArea: Bool = false, constant: CGFloat = .zero) -> Self {
        if (usingSafeArea) {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            ])
        } else {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
                self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
                self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
                self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
            ])
        }
        return self
    }

    @discardableResult
    /// Constraint the height and width anchors with the specified CGSize value.
    /// - Parameters:
    ///   - size: The size be used as the constraint constant.
    func constraintSize(to size: CGSize) -> Self {
        self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the height and width anchors with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value to be used as the constraint constant.
    func constraintSize(to constant: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the widthAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    func constraintWidth(to constant: CGFloat) -> Self {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the widthAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintWidth(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        self.widthAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the widthAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - multiplier: Factor value to be applied to the constraint.
    func constraintWidth(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> Self {
        self.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the heightAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    func constraintHeight(to constant: CGFloat) -> Self {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the heightAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    func constraintHeight(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        self.heightAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }

    @discardableResult
    /// Constraint the heightAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - multiplier: Factor value to be applied to the constraint.
    func constraintHeight(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> Self {
        self.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }
}
