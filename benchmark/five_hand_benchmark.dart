import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:poker_hands/poker_hands.dart';

class FiveHandBenchmark extends BenchmarkBase {

  const FiveHandBenchmark() : super("FiveHand");

  static void main() {
    new FiveHandBenchmark().report();
  }

  void run() {
    List<Card> cards = [
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.QUEEN, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
    ];

    FiveHand hand = new FiveHand(cards);
    hand.evaluate();
  }
}

main() {
  FiveHandBenchmark.main();
}