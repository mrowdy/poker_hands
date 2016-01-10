import "package:test/test.dart";

import "package:poker_hands/poker_hands.dart";

void main() {
  test("it throws up if less than 5 cards are provided", () {
    List<Card> cards = [
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.QUEEN, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
    ];

    expect(() => new FiveHand(cards), throwsException);
  });

  test("it throws up if more than 5 cards are provided", () {
    List<Card> cards = [
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.QUEEN, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
      new Card(Face.JACK, Suite.SPADE),
    ];

    expect(() => new FiveHand(cards), throwsException);
  });

  test("it detects royal flush", () {
    FiveHand hand = new FiveHand([
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.QUEEN, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
      new Card(Face.TEN, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.ROYAL_FLUSH);
  });

  test("it detects straight flush", () {
    FiveHand hand = new FiveHand([
      new Card(Face.NINE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.QUEEN, Suite.CLUB),
      new Card(Face.JACK, Suite.CLUB),
      new Card(Face.TEN, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.STRAIGHT_FLUSH);
  });

  test("it detects four of a kind", () {
    FiveHand hand = new FiveHand([
      new Card(Face.NINE, Suite.CLUB),
      new Card(Face.NINE, Suite.SPADE),
      new Card(Face.NINE, Suite.HEART),
      new Card(Face.NINE, Suite.DIAMOND),
      new Card(Face.TEN, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.FOUR_OF_A_KIND);
  });

  test("it detects full house", () {
    FiveHand hand = new FiveHand([
      new Card(Face.NINE, Suite.CLUB),
      new Card(Face.NINE, Suite.SPADE),
      new Card(Face.THREE, Suite.HEART),
      new Card(Face.THREE, Suite.DIAMOND),
      new Card(Face.THREE, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.FULL_HOUSE);
  });

  test("it detects flush", () {
    FiveHand hand = new FiveHand([
      new Card(Face.NINE, Suite.CLUB),
      new Card(Face.TEN, Suite.CLUB),
      new Card(Face.TWO, Suite.CLUB),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.KING, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.FLUSH);
  });

  test("it detects high straight", () {
    FiveHand hand = new FiveHand([
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.QUEEN, Suite.HEART),
      new Card(Face.KING, Suite.CLUB),
      new Card(Face.TEN, Suite.SPADE),
      new Card(Face.JACK, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.STRAIGHT);
  });

  test("it detects middle straight", () {
    FiveHand hand = new FiveHand([
      new Card(Face.EIGHT, Suite.CLUB),
      new Card(Face.SEVEN, Suite.HEART),
      new Card(Face.NINE, Suite.CLUB),
      new Card(Face.TEN, Suite.SPADE),
      new Card(Face.JACK, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.STRAIGHT);
  });

  test("it detects low straight", () {
    FiveHand hand = new FiveHand([
      new Card(Face.ACE, Suite.CLUB),
      new Card(Face.TWO, Suite.HEART),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.FIVE, Suite.SPADE),
      new Card(Face.FOUR, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.STRAIGHT);
  });

  test("it detects three of a kind", () {
    FiveHand hand = new FiveHand([
      new Card(Face.FIVE, Suite.CLUB),
      new Card(Face.FIVE, Suite.HEART),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.FIVE, Suite.SPADE),
      new Card(Face.FOUR, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.THREE_OF_A_KIND);
  });

  test("it detects two pairs", () {
    FiveHand hand = new FiveHand([
      new Card(Face.FIVE, Suite.CLUB),
      new Card(Face.FIVE, Suite.HEART),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.FOUR, Suite.SPADE),
      new Card(Face.FOUR, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.TWO_PAIR);
  });

  test("it detects one pairs", () {
    FiveHand hand = new FiveHand([
      new Card(Face.FIVE, Suite.CLUB),
      new Card(Face.FIVE, Suite.HEART),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.SIX, Suite.SPADE),
      new Card(Face.FOUR, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.ONE_PAIR);
  });

  test("it detects high card", () {
    FiveHand hand = new FiveHand([
      new Card(Face.FIVE, Suite.CLUB),
      new Card(Face.ACE, Suite.HEART),
      new Card(Face.THREE, Suite.CLUB),
      new Card(Face.SIX, Suite.SPADE),
      new Card(Face.FOUR, Suite.CLUB),
    ]);

    expect(hand.evaluate(), Hand.HIGH_CARD);
  });
}
