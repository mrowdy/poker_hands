import 'package:poker_hands/poker_hands.dart';

main(List<String> args) {

  // Create List of cards
  List<Card> cards = [
    new Card(Face.ACE, Suite.SPADE),
    new Card(Face.KING, Suite.SPADE),
    new Card(Face.QUEEN, Suite.SPADE),
    new Card(Face.JACK, Suite.SPADE),
    new Card(Face.TEN, Suite.SPADE)
  ];

  // Create a hand containing your cards
  FiveHand hand = new FiveHand(cards);

  // evaluate returns highest ranking hand
  print(hand.evaluate());
}
