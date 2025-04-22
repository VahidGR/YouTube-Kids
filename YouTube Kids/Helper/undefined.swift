//
//  undefined.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

func undefined<T>(_ message: String = "Value not defined") -> T {
    fatalError(message)
}

func unwrap<T>(_ optional: T?) -> T {
    optional ?? undefined()
}
