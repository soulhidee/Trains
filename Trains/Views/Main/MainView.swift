import SwiftUI

struct MainView: View {
    @State private var path = NavigationPath()
    var body: some View {
            VStack {
                LocationSwapView(path: $path)
                    .padding()
                Spacer()
            }
        }
    }

#Preview {
    TabBarView()
}
