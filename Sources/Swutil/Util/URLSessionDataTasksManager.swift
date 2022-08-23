//
//  URLSessionDataTasksManager.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//
import Foundation

public class URLSessionDataTasksManager: URLSessionDataTaskHandler {
    public static var shared = URLSessionDataTasksManager()
    public private(set) var tasks: [Int: URLSessionDataTask] = [:]

    private init() { }

    public func addTask(_ task: URLSessionDataTask, for hash: Int) {
        tasks[hash] = task
    }

    public func cancelTask(for hash: Int) {
        tasks[hash]?.cancel()
    }
}
