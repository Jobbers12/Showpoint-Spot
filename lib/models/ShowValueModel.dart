// Represents our Intensity for a given Cue. This is Nested inside our CueModel.
class ShowValueModel<T> {
  final T value;
  final bool isTracking;

  ShowValueModel.fromJson(Map<String, dynamic> json) :
    this.value = _forceCast(T, json['value']) ?? _getDefaultValue(T), // Coerced to Zero if the value doesn't exist for some reason.
    this.isTracking = json['isTracking'];

  static _forceCast(Type t, dynamic value) {
    if (value == null) {
      // Return null so _getDefaultValue will kick in.
      return null;
    }

    // If we are expecting a double, JSON might abbreviate what we think is a double to an int, so force it to be a double.
    // TODO: Doesn't currently work because JSON (value) passes int & double back as 'num'
    if (t is double && value is int) {
      return value.toDouble();
    }

    return value;
  }

  // Check type and coerce correct result if null
  static _getDefaultValue(Type t) {
    if (t is String) { return ''; }
    return 0;
  }
}