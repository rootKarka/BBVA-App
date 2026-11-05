import SwiftUI

// MARK: - Paleta de marca BBVA (tomada de bbva.pe)
extension Color {
    /// Crea un Color a partir de un hexadecimal, ej: Color(hex: 0x001391)
    init(hex: UInt32) {
        self.init(.sRGB,
                  red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue: Double(hex & 0xFF) / 255,
                  opacity: 1)
    }
}

enum BBVA {
    static let royal   = Color(hex: 0x001391) // Azul de botones/CTA del sitio web
    static let navy    = Color(hex: 0x072146) // Navy BBVA (títulos, fondos oscuros)
    static let core    = Color(hex: 0x004481) // Core Blue
    static let blue    = Color(hex: 0x1973B8) // Azul medio (iconos)
    static let sky     = Color(hex: 0x5BBEFF) // Azul cielo (acentos)
    static let aqua    = Color(hex: 0x2DCCCD) // Aqua (acentos)
    static let background = Color(hex: 0xF4F4F4)
    static let border  = Color(hex: 0xD3D3D3)
    static let error   = Color(hex: 0xDA3851)
    static let success = Color(hex: 0x48AE64)

    /// Degradado del banner superior del sitio (celeste -> azul profundo)
    static let headerGradient = LinearGradient(
        colors: [BBVA.sky, BBVA.royal, BBVA.navy],
        startPoint: .topLeading, endPoint: .bottomTrailing)

    static let heroGradient = LinearGradient(
        colors: [BBVA.blue, BBVA.royal],
        startPoint: .topLeading, endPoint: .bottomTrailing)

    /// Fuente personalizada (via .font(.custom)): serif en negrita como los títulos del sitio.
    static func serif(_ size: CGFloat) -> Font {
        .custom("Georgia-Bold", size: size)
    }
}
