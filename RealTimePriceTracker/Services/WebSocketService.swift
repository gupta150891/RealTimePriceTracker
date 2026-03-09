//
//  WebSocketService.swift
//  RealTimePriceTracker
//
//  Created by Paurush Gupta on 09/03/26.
//

import Foundation
import Combine

class WebSocketService {

    static let shared = WebSocketService()

    private var webSocketTask: URLSessionWebSocketTask?
    // passthrough gives only the latest value
    private let subject = PassthroughSubject<String, Never>()

    var publisher: AnyPublisher<String, Never> {
        subject.eraseToAnyPublisher()
    }

    func connect() {

        guard let url = URL(string: "wss://ws.postman-echo.com/raw") else { return }

        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()

        // we are starting to receive as soon as we connect.
        receive()
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }

    func send(message: String) {

        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error)
            }
        }
    }

    private func receive() {

        webSocketTask?.receive { [weak self] result in

            switch result {

            case .success(let message):

                switch message {

                case .string(let text):
                    self?.subject.send(text)

                default:
                    break
                }

            case .failure(let error):
                print(error)
            }
            
            // this has been added for continuos listening, it can also be removed if only single message listening.
            self?.receive()
        }
    }
}
