class TimeUtils {
  TimeUtils._();

  static String printDuration(Duration duration) {
    String negativeSign = duration.isNegative ? '-' : '';
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());
    String hoursPart =
        duration.inHours == 0 ? '' : '${twoDigits(duration.inHours)}:';
    return "$negativeSign$hoursPart$twoDigitMinutes:$twoDigitSeconds";
  }
}
