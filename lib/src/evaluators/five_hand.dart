part of poker_hands;

/**
 * Calculates the Rank of a 5 card Poker hand using bit manipulations.
 * Ported to dart from the original CPOL-Licensed javascript code by subskybox
 * In-depth article explaining how the rank function works available here:
 * http://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
 */
class FiveHand implements Evaluatable {
  List<Card> _cards;

  FiveHand(this._cards) {
    if (_cards.length != 5) {
      throw new Exception("only 5 cards supported");
    }
  }

  Hand evaluate() {
    int value = _calculateHandIndex(_getRanks(_cards), _getSuits(_cards));
    return _getHandFromValue(value);
  }

  /**
   * Calculates an unique index for each hand.
   * [ranks] are int representations of the cards faces
   * [suits] are int representation of the cards suites
   *
   * @Todo refactor this
   */
  int _calculateHandIndex(List<int> ranks, List<int> suits) {
    int rankBitField = _getRankBitField(ranks);
    double index = _getCardScore(ranks);

    index = index % 15 -
        ((rankBitField / (rankBitField & -rankBitField) == 31) ||
            _isAceLowStraight(rankBitField) ? 3 : 1);

    index -= (_isFlush(suits) ? 1 : 0) * (_isRoyalFlush(rankBitField) ? -5 : 1);

    return index.toInt();
  }

  /**
   * returns unique card score for [ranks].
   * Same ranks return same score
   */
  double _getCardScore(List<int> ranks) {
    int offset = 0;
    double score = 0.0;
    for (var i = 0; i < 5; i++) {
      offset = _getCardOffset(ranks[i]);
      score += offset * (((score / offset).toInt() & 15) + 1);
    }

    return score;
  }

  /**
   * returns [bool] whether [suits] is a flush or not
   */
  bool _isFlush(List<int> suits) {
    return suits[0] == suits[1] | suits[2] | suits[3] | suits[4];
  }

  /**
   * get bit field offset of [rank]
   */
  int _getCardOffset(int rank) => pow(2, rank * 4) as int;

  /**
   * returns int representation of [card] face
   * two == 2
   * ace == 14
   */
  int _getCardRank(Card card) => card.face().index + 2;

  /**
   * returns int representation of [card] suite
   * Heart == 1
   * Spade == 2
   * Club == 4
   * Diamond == 8
   */
  int _getCardSuite(Card card) {
    switch (card.suite()) {
      case Suite.HEART:
        return 1;
      case Suite.SPADE:
        return 2;
      case Suite.CLUB:
        return 4;
      case Suite.DIAMOND:
        return 8;
    }
  }

  /**
   * returns Hand representation of [value]
   */
  Hand _getHandFromValue(int value) {
    switch (value) {
      case 0:
        return Hand.FOUR_OF_A_KIND;
      case 1:
        return Hand.STRAIGHT_FLUSH;
      case 2:
        return Hand.STRAIGHT;
      case 3:
        return Hand.FLUSH;
      case 4:
        return Hand.HIGH_CARD;
      case 5:
        return Hand.ONE_PAIR;
      case 6:
        return Hand.TWO_PAIR;
      case 7:
        return Hand.ROYAL_FLUSH;
      case 8:
        return Hand.THREE_OF_A_KIND;
      case 9:
        return Hand.FULL_HOUSE;
    }
  }

  /**
   * Generate bit field based on [ranks]
   */
  int _getRankBitField(List<int> ranks) {
    return 1 << ranks[0] |
        1 << ranks[1] |
        1 << ranks[2] |
        1 << ranks[3] |
        1 << ranks[4];
  }

  /**
   * Converts [cards] suites to list of int
   */
  List<int> _getRanks(List<Card> cards) {
    List<int> ranks = new List<int>();
    cards.forEach((card) {
      ranks.add(_getCardRank(card));
    });

    return ranks;
  }

  /**
   * Converts [cards] faces to list of int
   */
  List<int> _getSuits(List<Card> cards) {
    List<int> suits = new List<int>();
    cards.forEach((card) {
      suits.add(_getCardSuite(card));
    });

    return suits;
  }

  /**
   * checks if given [bitField] represents an ace low straight
   * (ACE, 2, 3, 4, 5)
   */
  bool _isAceLowStraight(int bitField) => bitField == 0x403c;

  /**
   * checks if given [bitField] represents a royal flush
   */
  bool _isRoyalFlush(int bitField) => bitField == 0x7c00;
}
