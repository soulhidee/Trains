import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTimes: Set<DepartureTime> = []
    @State private var showTransfers = true
    
    
    var body: some View {
    }
}

#Preview {
    NavigationStack {
        FilterView()
    }
}
