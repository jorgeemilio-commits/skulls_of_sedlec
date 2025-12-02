
class Awesome {
  bool get isAwesome => true;
}

enum TipoCalavera {
  Real, 
  Campesino,  
  Sacerdote,
  Romantico,
  Criminal
}

class Carta {
  final TipoCalavera calaveraSup;
  final TipoCalavera calaveraInf;

  Carta(this.calaveraSup, this.calaveraInf);
  List<TipoCalavera> get calaveras => [calaveraSup, calaveraInf];
}