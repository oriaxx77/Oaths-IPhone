//
//  NSDataExt.swift
//  Oaths
//
//  Created by Bagyura Istvan on 25/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation

extension Data {
    func hexString() -> String {
        let bytes = UnsafeBufferPointer<UInt8>(start: (self as NSData).bytes.bindMemory(to: UInt8.self, capacity: self.count), count:self.count)
        let hexBytes = bytes.map{ String(format: "%02hhx", $0) }
        return hexBytes.joined(separator: "")
    }
}
