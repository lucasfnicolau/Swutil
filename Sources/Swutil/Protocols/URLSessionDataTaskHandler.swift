//
//  URLSessionDataTaskHandler.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 23/08/22.
//

import Foundation

public protocol URLSessionDataTaskHandler {
    var tasks: [Int: URLSessionDataTask] { get }

    func addTask(_ task: URLSessionDataTask, for hash: Int)
    func cancelTask(for hash: Int)
}
