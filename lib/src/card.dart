part of poker_hands;

class Card {
  final Face _face;
  final Suite _suite;

  Card(this._face, this._suite);

  Face face() => _face;
  Suite suite() => _suite;
}
