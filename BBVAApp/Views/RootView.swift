import SwiftUI

/// Decide qué flujo mostrar según haya o no usuario autenticado.
struct RootView: View {
    @EnvironmentObject private var store: AuthStore

    var body: some View {
        Group {
            if store.currentUser == nil {
                NavigationStack { LoginView() }
                    .tint(BBVA.royal)
            } else {
                HomeView()
            }
        }
        .animation(.easeInOut(duration: 0.35), value: store.currentUser)
    }
}
