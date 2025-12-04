// lib/src/matriz_logic.dart

import 'dart:collection';

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


// =======================================================
// LÓGICA DE PRE-PUNTUACIÓN (ANULACIÓN/VOLTEO)
// =======================================================

/// Cuenta los Criminales ('P') adyacentes a la posición (i, j).
int _contarCriminalesAdyacentes(List<List<String>> matriz, int i, int j) {
  int count = 0;
  if (matriz.isEmpty || matriz[0].isEmpty) return 0;
  int numFilas = matriz.length;
  int numColumnas = matriz[0].length;
  
  // Movimientos: Verticales directos y Horizontales saltando el separador.
  final adyacentes = [
    [-1, 0], [1, 0], // Vertical
    [0, -2], [0, 2], // Horizontal (saltando separador)
  ];

  for (final mov in adyacentes) {
    int ni = i + mov[0];
    int nj = j + mov[1];

    if (ni >= 0 && ni < numFilas && nj >= 0 && nj < numColumnas) {
      if (matriz[ni][nj] == 'P') { 
        count++;
      }
    }
  }
  return count;
}

List<List<String>> prepararMatrizParaPuntuacion(List<List<String>> matriz) {
  if (matriz.isEmpty || matriz[0].isEmpty) {
    return [];
  }
  List<List<String>> matrizModificable = matriz.map((row) => List<String>.from(row)).toList();
  int numFilas = matriz.length;
  
  Set<int> filasAVoltear = HashSet<int>(); 

  for (int i = 0; i < numFilas; i++) {
    for (int j = 0; j < matriz[0].length; j++) {
      if (matrizModificable[i][j] == 'R') {
        
        int criminalesAdyacentes = _contarCriminalesAdyacentes(matrizModificable, i, j);
        
        if (criminalesAdyacentes >= 2) {
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

  for (int i = 0; i < numFilas; i++) {
    if (filasAVoltear.contains(i)) {
      for (int j = 0; j < matriz[0].length; j++) {
        matrizModificable[i][j] = '_';
      }
    }
  }

  return matrizModificable;
}

// =======================================================
// LÓGICA ESPECÍFICA DE PUNTUACIÓN POR CARTA
// =======================================================

/// Punto por cada Noble (R) o Campesino (C) en cualquier posición de un nivel inferior.
int _puntuarNoble(List<List<String>> matrizPuntuacion, int fila, int col) {
  int puntos = 0;
  int numFilas = matrizPuntuacion.length;
  int numColumnas = matrizPuntuacion[0].length; 
  
  for (int k = fila + 1; k < numFilas; k++) { 
    for (int l = 0; l < numColumnas; l++) { 
      String caracterDebajo = matrizPuntuacion[k][l];
      if (caracterDebajo == 'R' || caracterDebajo == 'C') {
        puntos += 1;
      }
    }
  }
  return puntos;
}

/// Calcula los puntos de un Campesino ('C') basado en su posición relativa a todos los Nobles ('R').
int _puntuarCampesino(List<List<String>> matrizPuntuacion, int c_row, int c_col) {
  int numFilas = matrizPuntuacion.length;
  int numColumnas = matrizPuntuacion[0].length;
  
  for (int r_row = 0; r_row < numFilas; r_row++) {
    for (int r_col = 0; r_col < numColumnas; r_col++) {
      if (matrizPuntuacion[r_row][r_col] == 'R') {
        
        if (c_row >= r_row) {
          return 0; // El campesino está al mismo nivel o debajo del Rey
        }
      }
    }
  }
  
  return 2; // El campesino está a un nivel más alto que TODOS los Reyes
}

/// Verifica si la posición (i, j) es adyacente (ortogonalmente, saltando separadores)
/// a al menos un Sacerdote ('S').
bool _verificarAdyacenciaSacerdote(List<List<String>> matrizPuntuacion, int i, int j) {
  int numFilas = matrizPuntuacion.length;
  int numColumnas = matrizPuntuacion[0].length;
  
  final adyacentes = [
    [-1, 0], [1, 0], // Vertical
    [0, -2], [0, 2], // Horizontal (saltando separador)
  ];

  for (final mov in adyacentes) {
    int ni = i + mov[0];
    int nj = j + mov[1];

    if (ni >= 0 && ni < numFilas && nj >= 0 && nj < numColumnas) {
      if (matrizPuntuacion[ni][nj] == 'S') { 
        return true;
      }
    }
  }
  return false;
}

/// Calcula los puntos de un Criminal ('P').
/// Regla: 2 Puntos por cada Criminal adyacente a al menos un Sacerdote ('S').
int _puntuarCriminal(List<List<String>> matrizPuntuacion, int i, int j) {
  if (_verificarAdyacenciaSacerdote(matrizPuntuacion, i, j)) {
    return 2;
  }
  return 0;
}

// =======================================================
// FUNCIÓN PRINCIPAL DE PUNTUACIÓN
// =======================================================

/// Calcula la puntuación total y la desglosa por tipo de carta.
Map<String, int> calcularDesglosePuntuacion(List<List<String>> matriz) {
  if (matriz.isEmpty || matriz[0].isEmpty) {
    return {'R': 0, 'C': 0, 'S': 0, 'P': 0, 'Total': 0};
  }
  
  List<List<String>> matrizPuntuacion = prepararMatrizParaPuntuacion(matriz);
  
  // Inicializa el desglose, incluyendo al Criminal
  Map<String, int> desglose = {'R': 0, 'C': 0, 'S': 0, 'P': 0};
  
  // Set para rastrear las filas con Sacerdote ya puntuadas (Regla S)
  Set<int> filasSacerdotePuntuadas = {}; 
  
  int numFilas = matrizPuntuacion.length;
  int numColumnas = matrizPuntuacion[0].length;

  for (int i = 0; i < numFilas; i++) { 
    for (int j = 0; j < numColumnas; j++) {
      String caracter = matrizPuntuacion[i][j];
      
      switch (caracter) {
        case 'R':
          int puntos = _puntuarNoble(matrizPuntuacion, i, j);
          desglose['R'] = (desglose['R'] ?? 0) + puntos;
          break;
        case 'C':
          int puntos = _puntuarCampesino(matrizPuntuacion, i, j);
          desglose['C'] = (desglose['C'] ?? 0) + puntos;
          break;
        case 'S':
          // Regla del Sacerdote: 2 puntos por fila si no ha sido contada
          if (!filasSacerdotePuntuadas.contains(i)) {
            desglose['S'] = (desglose['S'] ?? 0) + 2;
            filasSacerdotePuntuadas.add(i);
          }
          break;
        case 'P':
          int puntos = _puntuarCriminal(matrizPuntuacion, i, j);
          desglose['P'] = (desglose['P'] ?? 0) + puntos;
          break;
        default:
          break;
      }
    }
  }

  int total = (desglose['R'] ?? 0) + (desglose['C'] ?? 0) + (desglose['S'] ?? 0) + (desglose['P'] ?? 0);
  desglose['Total'] = total;
  return desglose;
}

/// Función principal que devuelve la puntuación total (para compatibilidad con tests).
int calcularPuntuacionTotal(List<List<String>> matriz) {
  Map<String, int> desglose = calcularDesglosePuntuacion(matriz);
  return desglose['Total'] ?? 0;
}