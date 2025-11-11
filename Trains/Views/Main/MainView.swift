import SwiftUI

struct MainView: View {

    var body: some View {
        VStack {
            LocationSwapView()
                .padding()
            Spacer()
        }
    }
   
}

#Preview {
    TabBarView()
}
