import SwiftUI

struct RegisterView: View {
    @StateObject private var vm = RegisterViewModel()
    @EnvironmentObject private var store: AuthStore

    private var allFilled: Bool {
        ![vm.name, vm.email, vm.password, vm.confirmPassword]
            .contains { $0.trimmingCharacters(in: .whitespaces).isEmpty }
    }

    var body: some View {
        ZStack(alignment: .top) {
            BBVA.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Crea tu cuenta")
                        .font(BBVA.serif(28))
                        .foregroundStyle(BBVA.navy)
                    Text("Completa tus datos para empezar a usar BBVA.")
                        .font(.subheadline).foregroundStyle(.secondary)

                    BBVAField(title: "Nombre completo", icon: "person",
                              text: $vm.name, error: vm.nameError,
                              capitalization: .words)
                    BBVAField(title: "Correo electrónico", icon: "envelope",
                              text: $vm.email, error: vm.emailError,
                              keyboard: .emailAddress)
                    BBVAField(title: "Contraseña", icon: "lock",
                              text: $vm.password, isSecure: true, error: vm.passwordError)
                    BBVAField(title: "Confirmar contraseña", icon: "lock.rotation",
                              text: $vm.confirmPassword, isSecure: true, error: vm.confirmError)

                    Button {
                        Task { await vm.register(store: store) }
                    } label: {
                        if vm.isProcessing { ProgressView().tint(.white) } else { Text("Crear cuenta") }
                    }
                    .buttonStyle(BBVAPrimaryButtonStyle())
                    .disabled(!allFilled || vm.isProcessing)
                    .padding(.top, 6)
                }
                .padding(24)
            }

            // Feedback visual del éxito antes de navegar al Home
            if vm.showSuccess {
                Label("Cuenta creada", systemImage: "checkmark.circle.fill")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20).padding(.vertical, 12)
                    .background(BBVA.success, in: Capsule())
                    .shadow(radius: 8, y: 4)
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.spring(), value: vm.showSuccess)
        .navigationTitle("Registro")
        .navigationBarTitleDisplayMode(.inline)
    }
}
