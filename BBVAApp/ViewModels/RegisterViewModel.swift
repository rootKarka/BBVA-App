import Foundation
import Combine

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    @Published var nameError: String?
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var confirmError: String?
    @Published var showSuccess = false      // feedback visual "Cuenta creada"
    @Published var isProcessing = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $email.dropFirst().sink { [weak self] in self?.emailError = Validators.emailError($0) }
            .store(in: &cancellables)
        $password.dropFirst().sink { [weak self] in self?.passwordError = Validators.passwordError($0) }
            .store(in: &cancellables)
        // Compara confirmación vs contraseña cuando cambia cualquiera de las dos
        Publishers.CombineLatest($password, $confirmPassword)
            .dropFirst()
            .sink { [weak self] pass, confirm in
                self?.confirmError = (!confirm.isEmpty && pass != confirm) ? "Las contraseñas no coinciden" : nil
            }
            .store(in: &cancellables)
    }

    func register(store: AuthStore) async {
        // 1) Ningún campo vacío
        nameError = name.trimmingCharacters(in: .whitespaces).isEmpty ? "Ingresa tu nombre" : nil
        emailError = email.trimmingCharacters(in: .whitespaces).isEmpty
            ? "Ingresa tu correo" : (Validators.isValidEmail(email) ? nil : "Formato de correo inválido")
        passwordError = password.isEmpty ? "Ingresa una contraseña" : Validators.passwordError(password)
        confirmError = confirmPassword.isEmpty ? "Confirma tu contraseña"
            : (password != confirmPassword ? "Las contraseñas no coinciden" : nil)

        // 2) Email único contra la lista en memoria
        if emailError == nil, store.emailExists(email) {
            emailError = "Este correo ya está registrado"
        }
        guard [nameError, emailError, passwordError, confirmError].allSatisfy({ $0 == nil }) else { return }

        // 3) Guardar usuario en el store compartido (@EnvironmentObject)
        isProcessing = true
        let user = User(name: name.trimmingCharacters(in: .whitespaces),
                        email: email.trimmingCharacters(in: .whitespaces),
                        password: password)
        store.add(user)

        // 4) Feedback visual antes de navegar al Home
        showSuccess = true
        try? await Task.sleep(for: .seconds(1.3))
        store.startSession(user)   // RootView cambia a Home
    }
}
