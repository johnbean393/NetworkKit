//
// Copyright (c) Vatsal Manot
//

import API
import Foundation
import Merge
import Swift

public protocol HTTPEndpoint: Endpoint where Root: HTTPInterface {

}

// MARK: - Conformances -

open class BaseHTTPEndpoint<Root: HTTPInterface, Input, Output>:
    MutableEndpointBase<Root, Input, Output>, HTTPEndpoint {
    override open func buildRequestBase(
        from input: Input,
        context: BuildRequestContext
    ) throws -> HTTPRequest {
        if let input = input as? HTTPRequestPopulator {
            return try input.populate(HTTPRequest(url: context.root.baseURL))
        } else {
            return HTTPRequest(url: context.root.baseURL)
        }
    }
    
    override open func decodeOutputBase(
        from response: HTTPResponse,
        context: DecodeOutputContext
    ) throws -> Output {
        if let outputType = Output.self as? HTTPResponseDecodable.Type {
            return try outputType.init(from: response) as! Output
        }
        
        try response.validate()
        
        return try super.decodeOutput(from: response, context: context)
    }
}
