import SwiftUI

struct SplashView: View {
    // @State (y no @StateObject): es estado local, simple y de valor (Bool/Double)
    // que pertenece SOLO a esta vista. No hay clase observable que instanciar.
    @State private var isActive = false
    @State private var logoScale: CGFloat = 0.6
    @State private var logoOpacity = 0.0
    @State private var textOpacity = 0.0

    var body: some View {
        ZStack {
            if isActive {
                RootView().transition(.opacity)     // navegación automática al Login
            } else {
                splash.transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isActive)
    }

    private var splash: some View {
        ZStack {
            BBVA.headerGradient.ignoresSafeArea()

            VStack(spacing: 20) {
                BBVALogo(size: 56)
                    .scaleEffect(logoScale)          // animación de entrada: scale + opacity
                    .opacity(logoOpacity)

                Text("Creando oportunidades")
                    .font(BBVA.serif(18))            // fuente personalizada
                    .foregroundStyle(.white.opacity(0.9))
                    .opacity(textOpacity)
            }
        }
        .task {
            withAnimation(.spring(response: 0.9, dampingFraction: 0.65)) {
                logoScale = 1
                logoOpacity = 1
            }
            withAnimation(.easeIn(duration: 0.8).delay(0.5)) { textOpacity = 1 }

            try? await Task.sleep(for: .seconds(2))  // 2 segundos
            isActive = true
        }
    }
}
