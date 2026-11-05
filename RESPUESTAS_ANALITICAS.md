# Evaluación 03 – Desarrollo de Aplicaciones en iOS (BBVA)
**Alumno:** Pajares Villegas Patrick · Ciclo V

## 1. Splash: ¿Por qué `@State` y no `@StateObject`?
`@State` es el wrapper para **estado local y de tipo valor** (Bool, Double, Int…) que pertenece solo a una vista. En el Splash únicamente necesito un `Bool` (`isActive`) y valores de animación (`scale`, `opacity`); no hay lógica de negocio ni datos que compartir.
`@StateObject` sirve para **crear y conservar una clase `ObservableObject`** (ViewModel) durante el ciclo de vida de la vista. Usarlo aquí obligaría a crear una clase solo para guardar un Bool: más memoria, más código y una dependencia innecesaria (Combine/`@Published`). Además, SwiftUI invalida la vista automáticamente cuando cambia un `@State`, así que `isActive = true` dispara la transición al Login sin infraestructura adicional.
Regla: `@State` → estado simple y privado de la vista; `@StateObject` → la vista *posee* un objeto de referencia observable.

## 2. Login: `$viewModel.email` vs. pasar una copia del valor
`$vm.email` crea un **`Binding<String>`**: una referencia de lectura/escritura a la fuente de verdad (la propiedad `@Published` del ViewModel). Cuando el usuario escribe, el `TextField` modifica directamente `vm.email`, el ViewModel dispara su validación (Combine) y la vista se redibuja con el error actualizado. Hay **una sola fuente de verdad**.
Pasar `vm.email` (sin `$`) entrega una **copia inmutable** del `String` en ese instante: el campo solo mostraría el texto, no podría escribir de vuelta, y la copia queda desactualizada si el ViewModel cambia. `TextField`/`SecureField` exigen un `Binding` justamente porque necesitan escribir. En esta app, `BBVAField` recibe `@Binding var text` para reutilizar el mismo componente con distintos ViewModels.

## 3. Registro: ¿Por qué `@EnvironmentObject` para el usuario autenticado?
- **Evita el *prop drilling***: sin él habría que pasar el objeto por cada inicializador, incluso por vistas intermedias que no lo usan (Splash → Root → Login → Registro → Home).
- **Fuente de verdad única y compartida**: Registro lo escribe (`startSession`) y Home lo lee/limpia (`logout`); ambas ven el mismo estado y `RootView` cambia de flujo automáticamente.
- **Desacopla las vistas** y facilita pruebas/previews (se inyecta un store de prueba con `.environmentObject`).
- Se inyecta una vez en `BBVAApp` y cualquier descendiente lo obtiene. Contrapartida: si una vista lo lee y no fue inyectado, la app falla en tiempo de ejecución.

## 4. Home: filtrar con `.filter` dentro del `body`
El `body` se **re-evalúa muchas veces** (cualquier cambio de estado, scroll, teclado, animaciones). Si el `.filter` está ahí, se recorre y recalcula todo el array **en cada render**, aunque ni el texto ni los datos hayan cambiado. Con listas grandes (o filtros costosos como `localizedCaseInsensitiveContains`) causa tirones, consumo de CPU y UI lenta; además mezcla lógica con presentación.
**Solución con el ViewModel:** exponer `@Published var filteredItems` y calcularlo con Combine (`CombineLatest($searchText, $items)` + `.debounce` + `.map` + `.assign(to: &$filteredItems)`). Así el filtro se ejecuta **solo cuando cambian los insumos**, el debounce evita recalcular por cada tecla y la vista únicamente lee `filteredItems`. Es lo que implementa `HomeViewModel`.

## 5. Detalle: `ItemModel` por valor (struct) vs. `@ObservedObject`
Recibir un `struct` por valor es mejor aquí porque:
- El detalle **solo muestra** datos; no necesita observar cambios, así que no hay suscripciones ni invalidaciones extra.
- Los structs son **inmutables en la práctica** (`let`) y se copian: la vista no puede alterar por accidente el estado de la lista y no hay efectos secundarios compartidos.
- Es *thread-safe* y predecible; funciona de forma natural con `Identifiable` y `Hashable` para `NavigationLink(value:)`/`navigationDestination(for:)`; es más fácil de probar y de usar en previews.
**Cuándo cambiaría la decisión:** si el detalle debe **editar** el elemento o reflejar cambios que ocurren fuera de la vista (p. ej. cantidad en carrito, "favorito", datos que llegan en tiempo real de una API/base de datos), conviene un `ObservableObject` (`@ObservedObject`/`@StateObject`/`@Bindable`) como fuente de verdad compartida, o pasar un `@Binding` al struct.
