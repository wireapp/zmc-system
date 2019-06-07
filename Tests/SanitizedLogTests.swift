////
// Wire
// Copyright (C) 2019 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation


import XCTest
@testable import WireSystem

struct Item {
    var name: String
    var age: Int
}

extension Item: PrivateStringConvertible {
    static var redacted = "<redacted>"
    
    var privateDescription: String {
        return Item.redacted
    }
}


class SanitizedLogTests: XCTestCase {
    
    var item: Item!
    
    override func setUp() {
        super.setUp()
        item = Item(name: "top-secret", age: 99)
    }
    
    override func tearDown() {
        item = nil
        super.tearDown()
    }
    
    func testInterpolation() {
        let interpolated: SanitizedString = "\(item)"
        let redacted: SanitizedString = "<redacted>"
        XCTAssertEqual(redacted, interpolated)
    }
    
    func testInterpolationWithLiterals() {
        let interpolated: SanitizedString = "some \(item) item"
        let result = SanitizedString(stringLiteral: "some \(Item.redacted) item")
        XCTAssertEqual(result, interpolated)
    }    
}
