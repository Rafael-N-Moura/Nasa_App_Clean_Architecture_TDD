class DateInputConverter {
  static String format(DateTime date) {
    var dateSplited = date.toString().split(' ');
    return dateSplited.first;
  }
}
