//
//  Created by Petr Chmelar on 26/07/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import RxSwift

public extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        return map { _ in Void() }
    }
    
    func mapToEmpty() -> Observable<Element> {
        flatMap { _ -> Observable<Element> in Observable.empty() }
    }
}
