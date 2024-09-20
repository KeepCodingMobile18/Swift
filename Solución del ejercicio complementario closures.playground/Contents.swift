import Cocoa

/*
Ejercicio: Simulación de Proceso de Entrega de Ordenes

Objetivo:
Implementar un sistema que simula el flujo de trabajo de un restaurante para procesar y entregar órdenes utilizando Structs y Closures. Varias entidades (Camarero, Cocinero y Repartidor) interactúan en este sistema y transicionan entre diferentes etapas (preparación y entrega) usando retardos para simular el tiempo requerido para cada operación.

Requisitos:
1. Crear una estructura `Orden` que represente un pedido con propiedades para un identificador único y una descripción de la orden.
2. Implementar un `Camarero`que tiene que hacer el pedido. Se supone que es inmediato
2. Implementar un `Cocinero` que tiene la responsabilidad de preparar pedidos. Cada pedido tarda 5 segundos en completarse
3. Implementar un `Repartidor` que maneja la entrega de pedidos. El repartidor tarda 3 segundos en llevar el pedido
4. Probar el flujo completo con al menos una orden, asegurando que las operaciones de preparación y entrega se ejecutan coherentemente.
5. Cada vez que uno de los trabajadores, sea camarero, cocinero o repartidor, ejecuta su acción, debe imprimirse un mensaje por pantalla. Por ejemplo:

 El camarero hace el pedido Pizza Margherita.
 Cocinero está preparando el pedido Pizza Margherita.
 El pedido Pizza Margherita está listo.
 Repartidor ha recogido el pedido Pizza Margherita.
 El pedido Pizza Margherita ha sido entregado.
 Proceso completado para el pedido: Pizza Margherita
 
Instrucciones:
1. Usa los structs `Orden`, `Camarero`, `Cocinero` y `Repartidor` para modelar el sistema.
*/

import Foundation

// Struct que representa una Orden
struct Orden {
    let id: Int
    let descripcion: String
}

// Struct que representa un Camarero
struct Camarero {
    func pedirOrden(_ orden: Orden, completado: (Orden) -> Void) {
        print("El camarero hace el pedido \(orden.descripcion).")
        completado(orden)
    }
}

// Struct que representa un Cocinero
struct Cocinero {
    func prepararOrden(_ orden: Orden, completado: @escaping (Orden) -> Void) {
        print("Cocinero está preparando el pedido \(orden.descripcion).")
        // Simula tiempo de cocción con un retardo
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) {
            print("El pedido \(orden.descripcion) está listo.")
            completado(orden)
        }
    }
}

// Struct que representa un Repartidor
struct Repartidor {
    func entregarOrden(_ orden: Orden, completado: @escaping (Orden) -> Void) {
        print("Repartidor ha recogido el pedido \(orden.descripcion).")
        // Simula tiempo de entrega con un retardo
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            print("El pedido \(orden.descripcion) ha sido entregado.")
            completado(orden)
        }
    }
}

// Ejecución del flujo de trabajo
let pedido1 = Orden(id: 1, descripcion: "Pizza Margherita")

let camarero = Camarero()
let cocinero = Cocinero()
let repartidor = Repartidor()

camarero.pedirOrden(pedido1) { pedido in
    cocinero.prepararOrden(pedido) { pedidoPreparado in
        // Cuando la orden esté preparada, el Repartidor procede a entregarla
        repartidor.entregarOrden(pedidoPreparado) { pedidoEntregado in
            print("Proceso completado para el pedido: \(pedidoEntregado.descripcion)")
        }
    }
}
