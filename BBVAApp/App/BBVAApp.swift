import SwiftUI

@main
struct BBVAApp: App {
    // Un único AuthStore para toda la app, inyectado por @EnvironmentObject
    @StateObject private var store = AuthStore()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(store)
        }
    }
}
