# BBVA iOS – Evaluación 03 (SwiftUI + MVVM)

**Requisitos:** Xcode 16 o superior, iOS 17+.

## Cómo abrirlo
1. Descomprime y abre `BBVAApp.xcodeproj`.
2. En *Signing & Capabilities* elige tu Team (o usa el simulador).
3. Run (⌘R).

**Usuario demo:** `demo@bbva.pe` / `Bbva@2026` (o crea uno en Registro).

### Si Xcode no abre el .xcodeproj
Crea un proyecto nuevo *App* (SwiftUI, nombre `BBVAApp`, iOS 17), borra `BBVAAppApp.swift` y `ContentView.swift`, y arrastra la carpeta `BBVAApp/` (con Components, Models, Services, ViewModels, Views, App).

## Estructura
- `App/` punto de entrada · `Views/` Splash, Root, Login, Registro, Home, Detalle
- `ViewModels/` Login, Registro, Home (`@Published` + Combine)
- `Services/` `AuthStore` (@EnvironmentObject), `Validators`
- `Models/` `User`, `ItemModel` (struct Identifiable) · `Components/` tema BBVA y UI reutilizable
- `RESPUESTAS_ANALITICAS.md` respuestas a las 5 preguntas analíticas

## Paleta (bbva.pe)
Royal `#001391` · Navy `#072146` · Core `#004481` · Azul `#1973B8` · Sky `#5BBEFF` · Aqua `#2DCCCD`
