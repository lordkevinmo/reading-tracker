//
//  NetworkingPublisher.swift
//  Reading Tracker
//
//  Created by Moïse AGBENYA on 31/05/2021.
//

#if canImport(Combine)

import Foundation
import Combine

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
internal class NetworkingPublisher<Output, Failure>: Publisher where Failure: Swift.Error {
    private let callback: (AnySubscriber<Output, Failure>) -> URLSessionDataTask?

    init(callback: @escaping (AnySubscriber<Output, Failure>) -> URLSessionDataTask?) {
        self.callback = callback
    }

    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: AnySubscriber(subscriber), callback: callback)
        subscriber.receive(subscription: subscription)
    }
}

@available(OSX 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private extension NetworkingPublisher {
    class Subscription: Combine.Subscription {

        private let dataTask: URLSessionDataTask?

        init(subscriber: AnySubscriber<Output, Failure>, callback: @escaping (AnySubscriber<Output, Failure>) -> URLSessionDataTask?) {
            dataTask = callback(subscriber)
        }

        func request(_ demand: Subscribers.Demand) {
            // We don't care for the demand.
        }

        func cancel() {
            dataTask?.cancel()
        }
    }
}

#endif
