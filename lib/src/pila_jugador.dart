void main() {
  List<List<String>> matriz = [
    ['_', '_', '_', 'R', '_', '_', '_'],
    ['_', '_', '_', 'C', '_', '_', '_'],
    ['_', '_', 'E', '_', 'P', '_', '_'],
    ['_', '_', 'S', '_', 'E', '_', '_'],
    ['_', 'P', '_', 'P', '_', 'S', '_'],
    ['_', 'S', '_', 'R', '_', 'P', '_'],
  ];

  // El Map guardará el carácter (String) y su conteo (int)
  Map<String, int> contador = {};

  // Recorrer la matriz
  for (var fila in matriz) {
    for (var caracter in fila) {
      contador[caracter] = (contador[caracter] ?? 0) + 1;
    }
  }

  // Imprimir el resultado
  print('--- Conteo de Caracteres ---');
  contador.forEach((key, value) {
    print('$key: $value');
  });
}