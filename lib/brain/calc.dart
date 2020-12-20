// num keyPrice = 62.11;
// num refPrice = 0.03;

class Calculator {
  final double keyPrice;
  final double refPrice;

  Calculator(this.keyPrice, this.refPrice);

  String metalRoundNumber(String n) {
    num a = double.parse(n).floor();
    num r = (((double.parse(n) - a) / .11).roundToDouble());
    return (a + (9 == r ? 1 : .11 * r)).toStringAsFixed(2);
  }

  String roundNumber(String n) {
    return ((2 * double.parse(n)).roundToDouble() / 2).toStringAsFixed(2);
  }

  String keyToRefined(String keys) {
    return metalRoundNumber(
        ((double.parse(keys) * keyPrice * 100).roundToDouble() / 100)
            .toString());
  }

  String refinedToKeys(String refined) {
    return ((1 * double.parse(refined) / keyPrice * 100).roundToDouble() / 100)
        .toStringAsFixed(2);
  }

  String refinedToMoney(String refined) {
    return ((1 * double.parse(refined) * refPrice * 100).roundToDouble() / 100)
        .toStringAsFixed(2);
  }

  String keysToMoney(String keys) {
    return ((double.parse(keys) * keyPrice * refPrice * 100).roundToDouble() /
            100)
        .toStringAsFixed(2);
  }

  String moneyToKeys(String money) {
    return ((double.parse(money) / refPrice / keyPrice * 100).roundToDouble() /
            100)
        .toStringAsFixed(2);
  }

  String moneyToRefined(String money) {
    return metalRoundNumber(
        ((double.parse(money) / refPrice * 100).roundToDouble() / 100)
            .toString());
  }
}
