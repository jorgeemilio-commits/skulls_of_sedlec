// lib/src/matriz_logic.dart

List<List<String>> obtenerMatriz() {
  // Matriz corregida y definitiva
  return [
    ['_', '_', 'R', '_', 'R', '_', '_'],
    ['_', '_', 'S', '_', 'E', '_', '_'],
    ['_', 'P', '_', 'P', '_', 'S', '_'],
    ['_', 'S', '_', 'R', '_', 'P', '_'],
    ['R', '_', 'C', '_', 'C', '_', 'P'],
    ['E', '_', 'P', '_', 'E', '_', 'E'],
  ];
}

Map<String, int> contarCaracteres(List<List<String>> matriz) {
  Map<String, int> contador = {};
  for (var fila in matriz) {
    for (var caracter in fila) {
      contador[caracter] = (contador[caracter] ?? 0) + 1;
    }
  }
  return contador;
}

/// Calcula la puntuación total generada por todos los Nobles (R) en la matriz.
/// 
/// Regla Confirmada: 1 Punto por cada Noble (R) o Campesino (C) que se encuentre 
/// en una fila inferior (nivel inferior) en CUALQUIER columna.
int calcularPuntuacionNoble(List<List<String>> matriz) {
  int puntuacionTotal = 0;
  int numFilas = matriz.length;
  
  if (numFilas == 0) {
    return 0;
  }
  
  int numColumnas = matriz[0].length;

  // Recorre la matriz para encontrar a cada Noble (R)
  for (int i = 0; i < numFilas; i++) { // i = fila 
    for (int j = 0; j < numColumnas; j++) { // j = columna 
      
      // 1. Identifica si la calavera actual es un Noble ('R')
      if (matriz[i][j] == 'R') {
        // 2. Itera por las filas inferiores 
        for (int k = i + 1; k < numFilas; k++) { // k = fila inferior
          // 3. Itera por TODAS las columnas (l) en la fila inferior (k)
          for (int l = 0; l < numColumnas; l++) { // l = columna de la calavera objetivo
            String caracterDebajo = matriz[k][l];
            // 4. Si el carácter es Noble ('R') o Campesino ('C'), suma un punto
            if (caracterDebajo == 'R' || caracterDebajo == 'C') {
              puntuacionTotal += 1;
            }
          }
        }
      }
    }
  }

  return puntuacionTotal;
}