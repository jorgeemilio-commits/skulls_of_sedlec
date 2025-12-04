// example/skulls_of_sedlec_example.dart

import 'package:skulls_of_sedlec/skulls_of_sedlec.dart';

void main() {
  // Las funciones obtenidas a través del export
  final matriz = obtenerMatriz();
  
  // Usamos el nombre de la función refactorizada
  final puntuacionTotal = calcularPuntuacionTotal(matriz); 
  
  final conteo = contarCaracteres(matriz);

  print('--- Matriz de Pila ---');
  for (var fila in matriz) {
    print(fila.join(' '));
  }
  
  print('\n--- Puntuación Total ---');
  print('Puntuación Total (incluye Noble R): $puntuacionTotal puntos'); 

  print('\n--- Conteo de Caracteres ---');
  print(conteo);
}