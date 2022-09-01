//
//  UITableView+UICollectionView.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 15/08/22.
//

import UIKit

public extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

public extension UITableView {
    func registerCell(_ cellCass: UITableViewCell.Type) {
        register(cellCass, forCellReuseIdentifier: cellCass.reuseIdentifier)
    }

    func dequeue<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: cell.reuseIdentifier, for: indexPath) as? Cell
    }
}

public extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

public extension UICollectionView {
    func registerCell(_ cellCass: UICollectionViewCell.Type) {
        register(cellCass, forCellWithReuseIdentifier: cellCass.reuseIdentifier)
    }

    func dequeue<Cell: UICollectionViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath) as? Cell
    }
}
