class Calendar {
  Calendar() : super();

  /// 7개 열을 가진 그리드로 바로 변환될 수 있는, DateTime과 null로 이루어진 날짜 리스트를 반환합니다
  ///
  /// 일요일을 한 주의 시작으로 봅니다
  ///
  /// 예를 들어 어느 달의 시작이 목요일이라면, 목요일 전에 있는 weekdays만큼,
  /// 즉 4만큼의 null이 리스트의 시작에 삽입됩니다.
  ///
  /// 또한 어느 달의 끝이 수요일이라면, 수요일 후에 있는 weekdays만큼,
  /// 즉 3만큼의 null이 리스트의 끝에 삽입됩니다.
  List<DateTime?> generateCalendar(int year, int month) {
    int monthStartWeekday = getMonthStartWeekday(year, month);
    int monthEndWeekday = getMonthEndWeekDay(year, month);
    int monthEndDay = getMonthEndDay(year, month);
    int numPlaceholderAtStart = monthStartWeekday % 7;
    int numPlaceholderAtEnd = (7 - (monthEndWeekday % 7 + 1));
    List<DateTime?> calendar = [
      List.generate(numPlaceholderAtStart, (_) => null),
      List.generate(
          monthEndDay, (index) => new DateTime(year, month, index + 1)),
      List.generate(numPlaceholderAtEnd, (_) => null)
    ].expand((element) => element).toList();
    return calendar;
  }

  int getMonthStartWeekday(int year, int month) {
    DateTime monthStartDate = new DateTime(year, month, 1);
    return monthStartDate.weekday;
  }

  int getMonthEndDay(int year, int month) {
    DateTime monthEndDate = month == 2
        ? new DateTime(year, month, 29)
        : new DateTime(year, month, 31);
    if (month == monthEndDate.month) {
      return month == 2 ? 29 : 31;
    } else {
      return month == 2 ? 28 : 30;
    }
  }

  int getMonthEndWeekDay(int year, int month) {
    int monthEndDay = getMonthEndDay(year, month);
    DateTime monthEndDate = new DateTime(year, month, monthEndDay);
    return monthEndDate.weekday;
  }

  List<DateTime?> now() {
    DateTime now = new DateTime.now();
    return generateCalendar(now.year, now.month);
  }
}
