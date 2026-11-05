import SwiftUI

// MARK: - Logo
// MARK: - Logo
struct BBVALogo: View {

    var size: CGFloat = 56

    var body: some View {

        Image("bbva_logo")
            .resizable()
            .scaledToFit()
            .frame(width: size * 2, height: size * 2)
            .clipShape(
                RoundedRectangle(cornerRadius: size * 0.3)
            )
    }
}

// MARK: - Botón primario (se ve atenuado cuando está .disabled)
struct BBVAPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isEnabled ? BBVA.royal : BBVA.royal.opacity(0.35))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - Campo de texto reutilizable con error reactivo
struct BBVAField: View {
    let title: String
    let icon: String
    @Binding var text: String          // <- Binding ($): lectura Y escritura hacia el ViewModel
    var isSecure = false
    var error: String? = nil
    var keyboard: UIKeyboardType = .default
    var capitalization: TextInputAutocapitalization = .never

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(BBVA.core)

            HStack(spacing: 10) {
                Image(systemName: icon).foregroundStyle(BBVA.blue)
                if isSecure {
                    SecureField("", text: $text)
                } else {
                    TextField("", text: $text)
                        .keyboardType(keyboard)
                        .textInputAutocapitalization(capitalization)
                        .autocorrectionDisabled()
                }
            }
            .padding(14)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(error == nil ? BBVA.border : BBVA.error, lineWidth: 1)
            )

            if let error {
                Label(error, systemImage: "exclamationmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(BBVA.error)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: error)
    }
}
