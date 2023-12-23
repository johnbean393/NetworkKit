//
// Copyright (c) Vatsal Manot
//

import Foundation

extension SSE.EventSource {
    final class SessionDelegate: NSObject, URLSessionDataDelegate {
        enum Event {
            case didCompleteWithError(Error?)
            case didReceiveResponse(URLResponse, (URLSession.ResponseDisposition) -> Void)
            case didReceiveData(Data)
        }
        
        var onEvent: (Event) -> Void = { _ in }
        
        func urlSession(
            _ session: URLSession,
            task: URLSessionTask,
            didCompleteWithError error: Error?
        ) {
            onEvent(.didCompleteWithError(error))
        }
        
        func urlSession(
            _ session: URLSession,
            dataTask: URLSessionDataTask,
            didReceive response: URLResponse,
            completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
        ) {
            onEvent(.didReceiveResponse(response, completionHandler))
        }
        
        func urlSession(
            _ session: URLSession,
            dataTask: URLSessionDataTask,
            didReceive data: Data
        ) {
            onEvent(.didReceiveData(data))
        }
    }
}
