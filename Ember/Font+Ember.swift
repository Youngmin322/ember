//
//  Font+Ember.swift
//  Ember
//
//  Created by Youngmin Cho on 8/11/26.
//

import SwiftUI

extension Font {
    static let emberCaption = Font.custom(
        "Pretendard-Regular",
        size: 12,
        relativeTo: .caption
    )

    static let emberBody = Font.custom(
        "Pretendard-Regular",
        size: 15,
        relativeTo: .body
    )

    static let emberBodyEmphasis = Font.custom(
        "Pretendard-Medium",
        size: 15,
        relativeTo: .body
    )

    static let emberSectionTitle = Font.custom(
        "Pretendard-Bold",
        size: 17,
        relativeTo: .headline
    )
}
