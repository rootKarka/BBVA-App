import Foundation

// MARK: - Usuario
struct User: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var email: String
    var password: String
}

// MARK: - Elemento del listado (struct + Identifiable + Hashable para NavigationStack)
struct ItemModel: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let subtitle: String
    let symbol: String
    let imageName: String
    let category: String
    let description: String
    let benefit: String
    let requirement: String
    let cost: String
}

extension ItemModel {
    /// 9 productos BBVA hardcodeados (mínimo pedido: 8)
    static let samples: [ItemModel] = [
        ItemModel(
            name: "Cuenta Ganadora",
            subtitle: "Ahorra y participa en sorteos",
            symbol: "trophy.fill",
            imageName: "cuenta_ganadora",
            category: "Cuentas",
            description: "Ahorra desde S/1,500 y participa en \"Atrapa tus sueños\" para ganar premios, experiencias y viajes.",
            benefit: "Premios de hasta S/10 millones",
            requirement: "Saldo mínimo S/1,500",
            cost: "Sin costo de mantenimiento"),
        ItemModel(
            name: "Tarjeta de Crédito",
            subtitle: "100% online, hasta S/500 cashback",
            symbol: "creditcard.fill",
            imageName: "tarjetas",
            category: "Tarjetas",
            description: "Solicítala sin ir a una oficina y aprovecha el cashback por campañas como CYBER.",
            benefit: "Cashback de hasta S/500",
            requirement: "Ingresos demostrables",
            cost: "Membresía según perfil"),
        ItemModel(
            name: "Préstamo Efectivo",
            subtitle: "Dinero rápido para tus planes",
            symbol: "banknote.fill",
            imageName: "prestamo",
            category: "Préstamos",
            description: "Recibe el dinero en tu cuenta con cuotas fijas y plazos flexibles.",
            benefit: "Desembolso inmediato",
            requirement: "Ser mayor de 18 años",
            cost: "TCEA desde 18%"),
        ItemModel(
            name: "Crédito Hipotecario",
            subtitle: "Compra tu casa o departamento",
            symbol: "house.fill",
            imageName: "credito",
            category: "Préstamos",
            description: "Financia tu vivienda con plazos de hasta 20 años y acompañamiento personalizado.",
            benefit: "Plazo hasta 20 años",
            requirement: "Cuota inicial desde 10%",
            cost: "TCEA desde 9%"),
        ItemModel(
            name: "Seguro SOAT",
            subtitle: "Evita multas, contrátalo a tiempo",
            symbol: "car.fill",
            imageName: "seguro",
            category: "Seguros",
            description: "Contrata o renueva tu SOAT en minutos y evita multas costosas.",
            benefit: "Cobertura inmediata",
            requirement: "Placa del vehículo",
            cost: "Desde S/ 150 al año"),
        ItemModel(
            name: "Cuenta Sueldo",
            subtitle: "Cobra tu sueldo sin comisiones",
            symbol: "person.crop.circle.badge.checkmark",
            imageName: "cuenta",
            category: "Cuentas",
            description: "Recibe tu remuneración y accede a beneficios exclusivos para tu día a día.",
            benefit: "Retiros sin comisión",
            requirement: "Convenio con tu empleador",
            cost: "S/ 0 de mantenimiento"),
        ItemModel(
            name: "Depósito a Plazo",
            subtitle: "Haz crecer tu dinero",
            symbol: "chart.line.uptrend.xyaxis",
            imageName: "deposito",
            category: "Inversión",
            description: "Invierte con una tasa fija y conoce desde el inicio cuánto ganarás.",
            benefit: "Tasa fija garantizada",
            requirement: "Monto mínimo S/ 1,000",
            cost: "Sin comisiones"),
        ItemModel(
            name: "Seguro Vehicular",
            subtitle: "Protege tu auto todo el año",
            symbol: "shield.lefthalf.filled",
            imageName: "seguro_vehicular",
            category: "Seguros",
            description: "Cobertura contra choques, robo y daños a terceros con asistencia 24/7.",
            benefit: "Asistencia 24/7",
            requirement: "Vehículo menor a 10 años",
            cost: "Prima desde S/ 90 al mes"),
        ItemModel(
            name: "Fondos Mutuos",
            subtitle: "Invierte desde montos pequeños",
            symbol: "chart.pie.fill",
            imageName: "prestamo",
            category: "Inversión",
            description: "Diversifica tus ahorros con fondos administrados por especialistas.",
            benefit: "Diversificación",
            requirement: "Aporte inicial S/ 500",
            cost: "Comisión de administración anual")
    ]
}
