import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject private var store: AuthStore

    var body: some View {
        ZStack {
            BBVA.headerGradient.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {
                    VStack(spacing: 6) {
                        BBVALogo(size: 36)
                        Text("Banca por Internet")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.85))
                    }
                    .padding(.top, 32)

                    VStack(alignment: .leading, spacing: 18) {
                        Text("Ingresa a tu cuenta")
                            .font(BBVA.serif(26))
                            .foregroundStyle(BBVA.navy)

                        // $vm.email = Binding: la vista escribe en el ViewModel
                        BBVAField(title: "Correo electrónico", icon: "envelope",
                                  text: $vm.email, error: vm.emailError,
                                  keyboard: .emailAddress)

                        BBVAField(title: "Contraseña", icon: "lock",
                                  text: $vm.password, isSecure: true,
                                  error: vm.passwordError)

                        if let error = vm.loginError {
                            Label(error, systemImage: "xmark.octagon.fill")
                                .font(.footnote.weight(.semibold))
                                .foregroundStyle(BBVA.error)
                        }

                        Button("Ingresar") { vm.login(store: store) }
                            .buttonStyle(BBVAPrimaryButtonStyle())
                            .disabled(!vm.canSubmit)      // deshabilitado si hay campos vacíos

                        NavigationLink {
                            RegisterView()
                        } label: {
                            (Text("¿No tienes cuenta? ").foregroundColor(.secondary)
                             + Text("Regístrate").bold().foregroundColor(BBVA.royal))
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                        }

                        Text("Demo: demo@bbva.pe · By: Sen Karka")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(24)
                    .background(BBVA.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 24)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}
