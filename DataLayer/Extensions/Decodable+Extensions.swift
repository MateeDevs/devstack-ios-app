//
//  Created by Petr Chmelar on 12.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

public extension Decodable {
    static var stub: Data {
        stub(for: String(describing: self))
    }
    
    static var stubList: Data {
        stub(for: "\(String(describing: self))List")
    }
    
    private static func stub(for resourceName: String) -> Data {
        let bundle = Bundle(for: BundleToken.self)
        guard let path = bundle.path(forResource: resourceName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return Data() }
        return data
    }
}

private final class BundleToken {}
