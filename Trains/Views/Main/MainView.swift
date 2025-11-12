import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                LocationSwapView(path: $path)
                    .padding()
                Spacer()
            }
        }
    }
    
}

#Preview {
    TabBarView()
}
