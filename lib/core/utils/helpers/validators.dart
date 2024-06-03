class Validators {
  static final emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  /// Validate Email
  static bool emailIsCorrect({required String value}) {
    ///  REG EXP to match Arabic.
    final arabicRegExp = RegExp(r'[\u0600-\u06FF]+');

    if (arabicRegExp.hasMatch(value)) {
      return false;
    }

    final emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    );

    return emailRegExp.hasMatch(value);
  }
}
