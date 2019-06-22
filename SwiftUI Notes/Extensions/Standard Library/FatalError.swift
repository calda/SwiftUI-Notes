//
//  FatalError.swift
//  SwiftUI Notes
//
//  Created by Cal Stephens on 6/22/19.
//  Copyright © 2019 Cal Stephens. All rights reserved.
//

func fatalError<T>(
    _ message: String,
    line: UInt = #line,
    file: StaticString = #file) -> T
{
    Swift.fatalError(message)
}
