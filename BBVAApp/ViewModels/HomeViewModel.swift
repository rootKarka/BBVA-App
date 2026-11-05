import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var items: [ItemModel] = ItemModel.samples
    @Published var searchText = ""
    /// Resultado ya filtrado: la vista solo lo lee, no calcula nada en el body.
    @Published private(set) var filteredItems: [ItemModel] = ItemModel.samples

    init() {
        // Se recalcula SOLO cuando cambia el texto o el array (con debounce), no en cada render.
        Publishers.CombineLatest($searchText, $items)
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .map { text, items -> [ItemModel] in
                let q = text.trimmingCharacters(in: .whitespaces)
                guard !q.isEmpty else { return items }
                return items.filter {
                    $0.name.localizedCaseInsensitiveContains(q) ||
                    $0.subtitle.localizedCaseInsensitiveContains(q) ||
                    $0.category.localizedCaseInsensitiveContains(q)
                }
            }
            .assign(to: &$filteredItems)
    }
}
