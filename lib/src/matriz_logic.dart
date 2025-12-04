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

/// Cuenta los Criminales ('P') adyacentes a la posición (i, j), 
/// saltando columnas visuales (los separadores '_') para la adyacencia horizontal.
int _contarCriminalesAdyacentes(List<List<String>> matriz, int i, int j) {
  int count = 0;
  if (matriz.isEmpty || matriz[0].isEmpty) return 0;
  int numFilas = matriz.length;
  int numColumnas = matriz[0].length;
  
  // Movimientos corregidos: Verticales directos y Horizontales saltando el separador.
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

/// Pre-procesa la matriz volteando (haciendo '_') las dos filas 
/// de cualquier carta que contenga un Noble ('R') adyacente a >= 2 Criminales ('P').
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

/// Calcula los puntos de un Noble ('R') ubicado en (fila, col).
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

/// Calcula los puntos de un Campesino ('C').
/// Regla: 1 Punto por cada Campesino.
int _puntuarCampesino(List<List<String>> matrizPuntuacion, int fila, int col) {
  return 1;
}


// =======================================================
// FUNCIÓN PRINCIPAL DE PUNTUACIÓN
// =======================================================

/// Calcula la puntuación total y la desglosa por tipo de carta.
Map<String, int> calcularDesglosePuntuacion(List<List<String>> matriz) {
  if (matriz.isEmpty || matriz[0].isEmpty) {
    return {'R': 0, 'C': 0, 'Total': 0};
  }
  
  List<List<String>> matrizPuntuacion = prepararMatrizParaPuntuacion(matriz);
  
  Map<String, int> desglose = {'R': 0, 'C': 0};
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
        default:
          break;
      }
    }
  }

  int total = (desglose['R'] ?? 0) + (desglose['C'] ?? 0);
  desglose['Total'] = total;
  return desglose;
}

/// Función principal que devuelve la puntuación total (para compatibilidad con tests).
int calcularPuntuacionTotal(List<List<String>> matriz) {
  Map<String, int> desglose = calcularDesglosePuntuacion(matriz);
  return desglose['Total'] ?? 0;
}