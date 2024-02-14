List<int> getDaysInCurrentMonth() {
  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;
  int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

  List<int> daysList = List.generate(daysInMonth, (index) => index + 1);
  return daysList;
}
