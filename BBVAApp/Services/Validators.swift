import Foundation

enum Validators {
    /// Caracteres especiales válidos: NO incluye . , ; ni tildes/letras acentuadas.
    private static let specialChars = Set("!@#$%^&*()_+-=[]{}|\\/<>?:\"'`~¿¡€£")

    static func isValidEmail(_ email: String) -> Bool {
        let pattern = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", pattern)
            .evaluate(with: email.trimmingCharacters(in: .whitespaces))
    }

    /// Devuelve nil si es válido; si no, el mensaje a mostrar.
    static func emailError(_ email: String) -> String? {
        let t = email.trimmingCharacters(in: .whitespaces)
        if t.isEmpty { return nil }                       // vacío no muestra error (solo deshabilita el botón)
        return isValidEmail(t) ? nil : "Ingresa un correo con formato válido (ej. nombre@correo.com)"
    }

    static func passwordError(_ password: String) -> String? {
        if password.isEmpty { return nil }
        if password.count < 6 { return "Mínimo 6 caracteres" }
        if !password.contains(where: { $0.isUppercase }) { return "Debe incluir al menos una mayúscula" }
        if !password.contains(where: { specialChars.contains($0) }) {
            return "Incluye un carácter especial (ej. ! @ # $ %). No cuentan . , ; ni tildes"
        }
        return nil
    }
}
