import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    LoadingView()
}
