//
//  URLSessionDataTaskHandler.swift
//  Swutil
//
//  Created by Lucas Fernandez Nicolau on 17/08/22.
//

import Foundation

public class URLSessionDataTaskHandler {
    public static var shared = URLSessionDataTaskHandler()
    public var sessions: [Int: URLSessionDataTask] = [:]

    private init() { }
}
