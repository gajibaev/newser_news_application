class Months {
  static final months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String getMonthName(int number) {
    if (number <= 12 && number > 0) {
      return months[number - 1];
    } else {
      return '';
    }
  }
}
