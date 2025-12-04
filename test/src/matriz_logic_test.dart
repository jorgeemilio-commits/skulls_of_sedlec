
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
      
      const expectedScore = 23; 
      final puntuacion = calcularPuntuacionTotal(matriz);
      
      printMatriz(matriz, 'Escenario 2');
      print('Resultado Calculado: $puntuacion');
      print('Resultado Esperado: $expectedScore');
      
      expect(puntuacion, equals(expectedScore)); 
    });

test('Escenario 4: Matriz Compleja (Noble y Campesino)', () {

      final matriz = [
      ['_', '_', 'C', '_', 'P', '_', '_'],
      ['_', '_', 'S', '_', 'S', '_', '_'],
      ['_', 'P', '_', 'P', '_', 'S', '_'], 
      ['_', 'S', '_', 'R', '_', 'S', '_'],
      ['R', '_', 'C', '_', 'C', '_', 'P'],
      ['E', '_', 'P', '_', 'E', '_', 'E'],
      ]; 

      const expectedScore = 23; 
      
      final desglose = calcularDesglosePuntuacion(matriz);
      final puntuacionCalculada = desglose['Total'] ?? 0;

      printMatriz(matriz, 'Escenario 4');
      print('--- Desglose Calculado ---');
      print('Noble (R): ${desglose['R']}');
      print('Campesino (C): ${desglose['C']}');
      print('Sacerdote (S): ${desglose['S']}');
      print('Prisionero o Criminal (P): ${desglose['P']}');
      print('Resultado Calculado (Total): $puntuacionCalculada');
      print('Resultado Esperado: $expectedScore');
      print('--------------------------');
      
      expect(puntuacionCalculada, equals(expectedScore)); 
    });

    test('Escenario 5: Matriz Compleja (Noble y Campesino)', () {

      final matriz = [
      ['_', '_', 'C', '_', 'P', '_', '_'],
      ['_', '_', 'S', '_', 'S', '_', '_'],
      ['_', 'P', '_', 'P', '_', 'S', '_'], 
      ['_', 'S', '_', 'R', '_', 'S', '_'],
      ['R', '_', 'E', '_', 'S', '_', 'P'],
      ['E', '_', 'P', '_', 'E', '_', 'E'],
      ]; 

      const expectedScore = 31; 
      
      final desglose = calcularDesglosePuntuacion(matriz);
      final puntuacionCalculada = desglose['Total'] ?? 0;

      printMatriz(matriz, 'Escenario 4');
      print('--- Desglose Calculado ---');
      print('Noble (R): ${desglose['R']}');
      print('Campesino (C): ${desglose['C']}');
      print('Sacerdote (S): ${desglose['S']}');
      print('Prisionero o Criminal (P): ${desglose['P']}');
      print('Enamorado (E): ${desglose['E']}');
      print('Resultado Calculado (Total): $puntuacionCalculada');
      print('Resultado Esperado: $expectedScore');
      print('--------------------------');
      
      expect(puntuacionCalculada, equals(expectedScore)); 
    });

  });
}