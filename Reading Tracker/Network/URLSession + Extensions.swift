//
//  URLSession + Extensions.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

import Foundation

public protocol NetworkingSession {
    typealias CompletionHandler = (Response, Swift.Error?) -> Void
    func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask
}

extension URLSession: NetworkingSession {
    public func loadData(
        with urlRequest: URLRequest,
        queue: DispatchQueue,
        completionHandler: @escaping (Response, Swift.Error?) -> Void
        ) -> URLSessionDataTask {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            queue.async {
                let response = Response(
                    urlRequest: urlRequest,
                    data: data,
                    httpURLResponse: urlResponse as? HTTPURLResponse
                )
                completionHandler(response, error)
            }
        }
        task.resume()
        return task
    }
}
