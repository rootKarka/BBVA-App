import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    // Entradas (enlazadas con $ desde la vista)
    @Published var email = ""
    @Published var password = ""

    // Errores reactivos (@Published) que la vista muestra
    @Published var emailError: String?
    @Published var passwordError: String?
    @Published var loginError: String?

    // Datos válidos guardados de manera temporal (variables)
    private(set) var validEmail = ""
    private(set) var validPassword = ""

    private var cancellables = Set<AnyCancellable>()

    /// Botón .disabled mientras haya campos vacíos
    var canSubmit: Bool {
        !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }

    init() {
        // Validación en vivo conforme el usuario escribe
        $email.dropFirst()
            .sink { [weak self] value in
                self?.emailError = Validators.emailError(value)
                self?.loginError = nil
            }
            .store(in: &cancellables)

        $password.dropFirst()
            .sink { [weak self] value in
                self?.passwordError = Validators.passwordError(value)
                self?.loginError = nil
            }
            .store(in: &cancellables)
    }

    func login(store: AuthStore) {
        emailError = Validators.isValidEmail(email) ? nil : "Ingresa un correo con formato válido"
        passwordError = Validators.passwordError(password) ?? (password.isEmpty ? "Ingresa tu contraseña" : nil)
        guard emailError == nil, passwordError == nil else { return }

        // Guardado temporal de datos válidos
        validEmail = email.trimmingCharacters(in: .whitespaces)
        validPassword = password

        if let user = store.authenticate(email: validEmail, password: validPassword) {
            loginError = nil
            store.startSession(user)
        } else {
            loginError = "Correo o contraseña incorrectos"
        }
    }
}
