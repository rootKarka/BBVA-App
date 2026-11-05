import Foundation

/// Almacén compartido (en memoria) del usuario autenticado y los usuarios registrados.
/// Se inyecta con .environmentObject(store) en la raíz y se lee con @EnvironmentObject.
@MainActor
final class AuthStore: ObservableObject {
    @Published private(set) var users: [User] = [
        // Usuario de prueba para poder entrar sin registrarse
        User(name: "Cliente Demo", email: "demo@bbva.pe", password: "By Sen Karka")
    ]
    @Published private(set) var currentUser: User?

    /// Unicidad de email: se compara en minúsculas contra la lista en memoria.
    func emailExists(_ email: String) -> Bool {
        let e = email.trimmingCharacters(in: .whitespaces).lowercased()
        return users.contains { $0.email.lowercased() == e }
    }

    func authenticate(email: String, password: String) -> User? {
        let e = email.trimmingCharacters(in: .whitespaces).lowercased()
        return users.first { $0.email.lowercased() == e && $0.password == password }
    }

    func add(_ user: User) { users.append(user) }
    func startSession(_ user: User) { currentUser = user }
    func logout() { currentUser = nil }   // limpia el usuario -> RootView vuelve al Login
}
