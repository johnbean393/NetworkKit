//
// Copyright (c) Vatsal Manot
//

import Foundation
import Swift

public protocol HTTPSessionTask {
    func resume()
    func cancel()
}

// MARK: - Concrete Implementations -

extension URLSessionTask: HTTPSessionTask {
    
}
