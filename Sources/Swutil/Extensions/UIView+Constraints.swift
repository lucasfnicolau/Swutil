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

    /// Constraint the current view topAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    @discardableResult
    func top(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    /// Constraint the current view leadingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    @discardableResult
    func leading(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    /// Constraint the current view trailingAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    @discardableResult
    func trailing(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    /// Constraint the current view bottomAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    ///   - distance: Enum controlling if the constraint should be equalTo, lessThanOrEqualTo or greaterThanOrEqualTo the anchor.
    @discardableResult
    func bottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = .zero, distance: ConstraintDistance = .equalTo) -> Self {
        switch distance {
        case .equalTo:
            bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .greaterThanOrEqualTo:
            bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        case .lessThanOrEqualTo:
            bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        }
        return self
    }

    /// Constraint the current view centerY and centerX anchors with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    @discardableResult
    func center(to view: UIView) -> Self {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    /// Constraint the current view centerYAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    @discardableResult
    func centerY(to view: UIView, constant: CGFloat = .zero) -> Self {
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        return self
    }

    /// Constraint the current view centerXAnchor with the anchor received by parameter.
    /// - Parameters:
    ///   - view: The view to be used as reference.
    ///   - constant: A custom constant to be used in the constraints.
    @discardableResult
    func centerX(to view: UIView, constant: CGFloat = .zero) -> Self {
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        return self
    }

    /// Constraint all the four main anchors (top, leading, trailing and bottom) of the current view with the anchor received by paremeter.
    /// - Parameters:
    ///   - view: The view where the constraint should be applied to.
    ///   - usingSafeArea: Boolean controlling the use of the safe area when applying the constraints.
    ///   - constant: A custom constant to be used in the constraints.
    @discardableResult
    func snap(to view: UIView, usingSafeArea: Bool = false, constant: CGFloat = .zero) -> Self {
        if (usingSafeArea) {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant),
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -constant),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor, constant: constant),
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant),
                bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant)
            ])
        }
        return self
    }

    /// Constraint the height and width anchors with the specified CGSize value.
    /// - Parameters:
    ///   - size: The size be used as the constraint constant.
    @discardableResult
    func size(to size: CGSize) -> Self {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }

    /// Constraint the height and width anchors with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value to be used as the constraint constant.
    @discardableResult
    func size(to constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Constraint the widthAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    @discardableResult
    func width(to constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Constraint the widthAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    @discardableResult
    func width(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        widthAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }

    /// Constraint the widthAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - multiplier: Factor value to be applied to the constraint.
    @discardableResult
    func width(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> Self {
        widthAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }

    /// Constraint the heightAnchor with the specified CGFloat value.
    /// - Parameters:
    ///   - constant: The value be used as the constraint constant.
    @discardableResult
    func height(to constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    /// Constraint the heightAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    @discardableResult
    func height(to anchor: NSLayoutAnchor<NSLayoutDimension>) -> Self {
        heightAnchor.constraint(equalTo: anchor).isActive = true
        return self
    }

    /// Constraint the heightAnchor with the specified anchor.
    /// - Parameters:
    ///   - anchor: The layout anchor to be used as reference.
    ///   - multiplier: Factor value to be applied to the constraint.
    @discardableResult
    func height(to anchor: NSLayoutDimension, multiplier: CGFloat = 1.0) -> Self {
        heightAnchor.constraint(equalTo: anchor, multiplier: multiplier).isActive = true
        return self
    }
}
