//
//  NSDataExt.swift
//  Oaths
//
//  Created by Bagyura Istvan on 25/08/16.
//  Copyright © 2016 p92. All rights reserved.
//

import Foundation

extension NSData {
    func hexString() -> String {
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        let hexBytes = bytes.map{ String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
}