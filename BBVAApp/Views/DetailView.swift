import SwiftUI

struct DetailView: View {
    // Recibe el modelo POR VALOR (struct): copia inmutable, sin observación necesaria
    let item: ItemModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // HERO: imagen grande arriba
                ZStack {
                    BBVA.heroGradient

                        Circle()
                            .fill(.white.opacity(0.12))
                            .frame(width: 220)
                            .offset(x: 90, y: -50)

                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 402, height: 390)
                            .shadow(radius: 10, y: 6)
                }
                .frame(height: 260)
                .clipped()

                VStack(alignment: .leading, spacing: 18) {
                    Text(item.category.uppercased())
                        .font(.caption.weight(.bold))
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(BBVA.sky.opacity(0.25), in: Capsule())
                        .foregroundStyle(BBVA.core)

                    Text(item.name)
                        .font(BBVA.serif(30))
                        .foregroundStyle(BBVA.navy)

                    Text(item.description)
                        .font(.body).foregroundStyle(.secondary)

                    // Atributos adicionales del modelo (3)
                    VStack(spacing: 12) {
                        AttributeCard(icon: "gift.fill", label: "Beneficio", value: item.benefit)
                        AttributeCard(icon: "checklist", label: "Requisito", value: item.requirement)
                        AttributeCard(icon: "percent", label: "Costo / Tasa", value: item.cost)
                    }

                    Button("Lo quiero") { }
                        .buttonStyle(BBVAPrimaryButtonStyle())
                        .padding(.top, 8)
                }
                .padding(24)
            }
        }
        .background(BBVA.background)
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct AttributeCard: View {
    let icon: String, label: String, value: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(BBVA.blue)
                .frame(width: 36, height: 36)
                .background(BBVA.sky.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading, spacing: 2) {
                Text(label).font(.caption).foregroundStyle(.secondary)
                Text(value).font(.subheadline.weight(.semibold)).foregroundStyle(BBVA.navy)
            }
            Spacer()
        }
        .padding(14)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
    }
}
