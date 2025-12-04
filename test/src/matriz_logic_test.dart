
import 'package:test/test.dart';
import 'package:skulls_of_sedlec/skulls_of_sedlec.dart'; 

void main() {
  
  void printMatriz(List<List<String>> matriz, String nombre) {
    print('\n--- Matriz de Prueba: $nombre ---');
    for (var fila in matriz) {
      print(fila.join(' '));
    }
  }

  group('Pruebas de Puntuación Total (Noble y Campesino) - Personalizadas', () {
    
    test('Escenario 1: Noble y Campesino en Pila Simple', () {
      
      final matriz = [
        ['_', 'R', '_'], 
        ['_', 'C', '_'], 
        ['R', '_', 'C'], 
        ['R', '_', 'C'], 
      ]; 

      const expectedScore = 7; 
      final puntuacion = calcularPuntuacionTotal(matriz);
      
      printMatriz(matriz, 'Escenario 1');
      print('Resultado Calculado: $puntuacion');
      print('Resultado Esperado: $expectedScore');
      
      expect(puntuacion, equals(expectedScore)); 
    });

    test('Escenario 2: Matriz Compleja', () {

      final matriz = [
      ['_', '_', 'R', '_', 'P', '_', '_'],
      ['_', '_', 'S', '_', 'E', '_', '_'],
      ['_', 'P', '_', 'P', '_', 'S', '_'],
      ['_', 'S', '_', 'R', '_', 'S', '_'],
      ['R', '_', 'C', '_', 'C', '_', 'P'],
      ['E', '_', 'P', '_', 'E', '_', 'E'],
      ]; 
      
      const expectedScore = 7; 
      final puntuacion = calcularPuntuacionTotal(matriz);
      
      printMatriz(matriz, 'Escenario 2');
      print('Resultado Calculado: $puntuacion');
      print('Resultado Esperado: $expectedScore');
      
      expect(puntuacion, equals(expectedScore)); 
    });

 test('Escenario 3: Rey Muerto', () {

      final matriz = [
      ['_', '_', 'R', '_', 'P', '_', '_'],
      ['_', '_', 'S', '_', 'E', '_', '_'],
      ['_', 'P', '_', 'P', '_', 'S', '_'],
      ['_', 'S', '_', 'R', '_', 'P', '_'],
      ['R', '_', 'C', '_', 'C', '_', 'P'],
      ['E', '_', 'P', '_', 'E', '_', 'E'],
      ]; 
      
      const expectedScore = 3; 
      final puntuacion = calcularPuntuacionTotal(matriz);
      
      printMatriz(matriz, 'Escenario 3');
      print('Resultado Calculado: $puntuacion');
      print('Resultado Esperado: $expectedScore');
      
      expect(puntuacion, equals(expectedScore)); 
    });

test('Escenario 4: Matriz Compleja (Noble y Campesino)', () {

      final matriz = [
      ['_', '_', 'C', '_', 'P', '_', '_'],
      ['_', '_', 'S', '_', 'C', '_', '_'],
      ['_', 'P', '_', 'P', '_', 'S', '_'], 
      ['_', 'S', '_', 'R', '_', 'S', '_'],
      ['R', '_', 'C', '_', 'C', '_', 'P'],
      ['E', '_', 'P', '_', 'E', '_', 'E'],
      ]; 

      const expectedScore = 7; 
      
      final desglose = calcularDesglosePuntuacion(matriz);
      final puntuacionCalculada = desglose['Total'] ?? 0;

      printMatriz(matriz, 'Escenario 2');
      print('--- Desglose Calculado ---');
      print('Noble (R): ${desglose['R']}');
      print('Campesino (C): ${desglose['C']}');
      print('Resultado Calculado (Total): $puntuacionCalculada');
      print('Resultado Esperado: $expectedScore');
      print('--------------------------');
      
      expect(puntuacionCalculada, equals(expectedScore)); 
    });

  });
}