class DateToStringConverter {
  static String convert(DateTime date) {
    var dateSplitted = date.toString().split(' ');
    return dateSplitted.first;
  }
}
