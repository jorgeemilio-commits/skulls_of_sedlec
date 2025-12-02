// test/puntuacion_noble_test.dart
import 'package:test/test.dart';

// Importa las funciones que acabas de modificar en lib/src/matriz_logic.dart
import 'package:skulls_of_sedlec/src/matriz_logic.dart'; 

void main() {
  group('Pruebas de Puntuación del Noble (R)', () {
    
    // --- Caso 1: La matriz proporcionada por el usuario (Esperado: 2) ---
    test('Puntuación correcta para la matriz de ejemplo', () {
      final matriz = obtenerMatriz();
      final puntuacion = calcularPuntuacionNoble(matriz);
      
      // El Noble en (0,3) ve a C(1,3) y R(5,3) debajo. Total: 2 puntos.
      expect(puntuacion, equals(2));
    });

    // --- Caso 2: Puntuación máxima en una columna (Esperado: 4) ---
    test('Calcula múltiples R/C debajo de un Noble', () {
      final matrizMaxima = [
        ['R'], // Noble en (0,0)
        ['C'], // +1
        ['R'], // +1
        ['C'], // +1
        ['R'], // +1
      ]; 
      final puntuacion = calcularPuntuacionNoble(matrizMaxima);
      expect(puntuacion, equals(4));
    });

    // --- Caso 3: Noble al final de la pila (Esperado: 0) ---
    test('Noble en la última fila no puntúa', () {
      final matrizFilaFinal = [
        ['C', 'R'], 
        ['E', 'R'], // Noble en (1,1) no tiene nada debajo
      ]; 
      final puntuacion = calcularPuntuacionNoble(matrizFilaFinal);
      expect(puntuacion, equals(0));
    });
    
    // --- Caso 4: No hay Noble en la pila (Esperado: 0) ---
    test('Devuelve 0 si no hay Nobles en la matriz', () {
      final matrizSinNoble = [
        ['C', 'E'], 
        ['S', 'P'], 
        ['_', '_'],
      ]; 
      final puntuacion = calcularPuntuacionNoble(matrizSinNoble);
      expect(puntuacion, equals(0));
    });
    
    // --- Caso 5: La matriz está vacía (Esperado: 0) ---
    test('Devuelve 0 si la matriz está vacía', () {
      final matrizVacia = <List<String>>[]; 
      final puntuacion = calcularPuntuacionNoble(matrizVacia);
      expect(puntuacion, equals(0));
    });
  });
}