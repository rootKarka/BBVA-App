import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: AuthStore
    @StateObject private var vm = HomeViewModel()

    private var firstName: String {
        store.currentUser?.name.split(separator: " ").first.map(String.init) ?? "cliente"
    }

    var body: some View {
        NavigationStack {
            List {
                // Cabecera de bienvenida
                Section {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hola, \(firstName)")
                            .font(BBVA.serif(26))
                            .foregroundStyle(BBVA.navy)
                        Text("Descubre los productos que tenemos para ti")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }

                if vm.filteredItems.isEmpty {
                    ContentUnavailableView.search(text: vm.searchText)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }

                // La vista solo LEE filteredItems; el filtrado vive en el ViewModel
                ForEach(vm.filteredItems) { item in
                    NavigationLink(value: item) { ItemRow(item: item) }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Productos")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $vm.searchText, prompt: "Buscar productos BBVA")
            .navigationDestination(for: ItemModel.self) { item in
                DetailView(item: item)              // se pasa el struct por valor
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.logout()              // limpia el usuario y vuelve al Login
                    } label: {
                        Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                }
            }
        }
        .tint(BBVA.royal)
    }
}

struct ItemRow: View {

    let item: ItemModel

    var body: some View {

        HStack(spacing: 14) {

            ZStack {
                Circle()
                    .fill(BBVA.heroGradient)
                    .frame(width: 52, height: 52)

                Image(systemName: item.symbol)
                    .font(.title3)
                    .foregroundStyle(.white)
            }

            VStack(alignment: .leading, spacing: 3) {

                Text(item.name)
                    .font(.headline)
                    .foregroundStyle(BBVA.navy)

                Text(item.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}
