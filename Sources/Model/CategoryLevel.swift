//
//  CategoryLevel.swift
//  Ello
//
//  Created by Colin Gray on 6/14/2016.
//  Copyright (c) 2016 Ello. All rights reserved.
//

public enum CategoryLevel: String, Equatable {
    case Meta = "meta"
    case Primary = "primary"
    case Secondary = "secondary"
    case Tertiary = "tertiary"
}

public func == (lhs: CategoryLevel, rhs: CategoryLevel) -> Bool {
    return lhs.rawValue == rhs.rawValue
}
