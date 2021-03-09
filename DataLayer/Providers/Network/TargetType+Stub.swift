//
//  Created by Petr Chmelar on 28.02.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Moya

extension TargetType {
    func stub<T>(_ networkType: T.Type) -> Data {
        stub(for: String(describing: type(of: networkType)))
    }
    
    func stubList<T>(_ networkType: T.Type) -> Data {
        stub(for: "\(String(describing: type(of: networkType)))List")
    }
    
    private func stub(for resourceName: String) -> Data {
        let bundle = Bundle(for: BundleToken.self)
        guard let path = bundle.path(forResource: resourceName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return Data() }
        return data
    }
}

private final class BundleToken {}
