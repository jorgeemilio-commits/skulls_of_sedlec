
import 'package:skulls_of_sedlec/src/matriz_logic.dart'; 

void main() {
  // 1. Obtener la matriz
  final matriz = obtenerMatriz();
  print('--- Matriz de Pila ---');
  for (var fila in matriz) {
    print(fila.join(' '));
  }
  
  // 2. Calcular y mostrar la puntuación del Noble (R)
  final puntuacionNoble = calcularPuntuacionNoble(matriz);
  print('\n--- Puntuación ---');
  print('Puntuación Noble (R): $puntuacionNoble puntos'); 

  // 3. Mostrar el conteo de caracteres
  final conteo = contarCaracteres(matriz);
  print('\n--- Conteo de Caracteres ---');
  print(conteo);
}