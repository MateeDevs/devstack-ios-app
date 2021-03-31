//
//  Created by Petr Chmelar on 09.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Foundation

extension Bundle {
    static let current: Bundle = Bundle(for: BundleToken.self)
}

private final class BundleToken {}
