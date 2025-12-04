// lib/src/matriz_logic.dart

List<List<String>> obtenerMatriz() {
  // La matriz corregida y definitiva para los cálculos
  return [
    ['_', '_', 'R', '_', 'P', '_', '_'],
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


/// Cuenta los Criminales ('P') adyacentes a la posición (i, j), 
/// saltando columnas visuales (los separadores '_') para la adyacencia horizontal.
int _contarCriminalesAdyacentes(List<List<String>> matriz, int i, int j) {
  int count = 0;
  int numFilas = matriz.length;
  int numColumnas = matriz[0].length;
  
  // MOVIMIENTOS CORREGIDOS: Verticales directos y Horizontales saltando 2 columnas.
  final adyacentes = [
    [-1, 0], [1, 0], // Vertical: Fila arriba/abajo
    [0, -2], [0, 2], // Horizontal: Columna de carta adyacente (saltando separador)
  ];

  for (final mov in adyacentes) {
    int ni = i + mov[0]; // Nueva fila
    int nj = j + mov[1]; // Nueva columna

    // CHEQUEO DE LÍMITES (evita out of bounds)
    if (ni >= 0 && ni < numFilas && nj >= 0 && nj < numColumnas) {
      // Solo se cuenta si el carácter es 'P'.
      if (matriz[ni][nj] == 'P') { 
        count++;
      }
    }
  }
  return count;
}

/// Pre-procesa la matriz volteando (haciendo '_') las dos filas 
/// de cualquier carta que contenga un Noble ('R') adyacente a >= 2 Criminales ('P').
List<List<String>> prepararMatrizParaPuntuacion(List<List<String>> matriz) {
  // Clonar la matriz para modificarla
  List<List<String>> matrizModificable = matriz.map((row) => List<String>.from(row)).toList();
  int numFilas = matriz.length;
  int numColumnas = matriz[0].length;
  
  Set<int> filasAVoltear = {}; 

  for (int i = 0; i < numFilas; i++) {
    for (int j = 0; j < numColumnas; j++) {
      if (matrizModificable[i][j] == 'R') {
        
        int criminalesAdyacentes = _contarCriminalesAdyacentes(matrizModificable, i, j);
        
        if (criminalesAdyacentes >= 2) {
          // Si cumple la condición de volteo, identificar las dos filas de la carta.
          int filaSuperior = (i ~/ 2) * 2; 
          int filaInferior = filaSuperior + 1;
          
          filasAVoltear.add(filaSuperior);
          if (filaInferior < numFilas) {
            filasAVoltear.add(filaInferior);
          }
        }
      }
    }
  }

  // Ejecutar el volteo (flip)
  for (int i = 0; i < numFilas; i++) {
    if (filasAVoltear.contains(i)) {
      for (int j = 0; j < numColumnas; j++) {
        matrizModificable[i][j] = '_';
      }
    }
  }

  return matrizModificable;
}

// =======================================================
// LÓGICA DE PUNTUACIÓN DE REYES O NOBLES
// =======================================================

/// Punto por cada Noble (R) o Campesino (C) en cualquier posición
/// de un nivel inferior.
int _puntuarNoble(List<List<String>> matrizPuntuacion, int fila, int col) {
  int puntos = 0;
  int numFilas = matrizPuntuacion.length;
  int numColumnas = matrizPuntuacion[0].length;
  
  // Itera por las filas inferiores (k)
  for (int k = fila + 1; k < numFilas; k++) { 
    
    // Itera por TODAS las columnas (l) en la fila inferior (k)
    for (int l = 0; l < numColumnas; l++) { 
      String caracterDebajo = matrizPuntuacion[k][l];
      
      if (caracterDebajo == 'R' || caracterDebajo == 'C') {
        puntos += 1;
      }
    }
  }
  return puntos;
}


// =======================================================
// FUNCIÓN DE PUNTUACIÓN
// =======================================================

int calcularPuntuacionTotal(List<List<String>> matriz) {
  // Aplica las anulaciones primero
  List<List<String>> matrizPuntuacion = prepararMatrizParaPuntuacion(matriz);
  
  int puntuacionTotal = 0;
  int numFilas = matrizPuntuacion.length;
  
  if (numFilas == 0) return 0;
  
  int numColumnas = matrizPuntuacion[0].length;

  // Recorre la matrizPuntuacion para encontrar cada calavera puntuable
  for (int i = 0; i < numFilas; i++) { 
    for (int j = 0; j < numColumnas; j++) {
      String caracter = matrizPuntuacion[i][j];
      
      switch (caracter) {
        case 'R':
          // Puntuación del Noble (R)
          puntuacionTotal += _puntuarNoble(matrizPuntuacion, i, j);
          break;
        default:
          // Solo puntúa R por ahora
          break;
      }
    }
  }

  return puntuacionTotal;
}