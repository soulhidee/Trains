import Foundation

import SwiftUI

struct Story {
    let backgroundImage: Image
    let title: String
    let description: String

    static let story1 = Story(
        backgroundImage: Image(.story1),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story2 = Story(
        backgroundImage: Image(.story2),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story3 = Story(
        backgroundImage: Image(.story3),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )


}
