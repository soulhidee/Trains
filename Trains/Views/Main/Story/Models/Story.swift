import Foundation

import SwiftUI

struct Story: Identifiable {
    let id = UUID()
    let backgroundImage: Image
    let title: String
    let description: String
    

    static let story1 = Story(
        backgroundImage: Image(.story1),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story2 = Story(
        backgroundImage: Image(.story2),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story3 = Story(
        backgroundImage: Image(.story3),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )

    static let story4 = Story(
        backgroundImage: Image(.story4),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )
    
    static let story5 = Story(
        backgroundImage: Image(.story5),
        title: "Text Text Text Text Text Text Text Text Text Text",
        description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
    )

}
