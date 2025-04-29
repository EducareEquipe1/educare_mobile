import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RendezVousCalendarView extends StatefulWidget {
  const RendezVousCalendarView({Key? key}) : super(key: key);

  @override
  State<RendezVousCalendarView> createState() => _RendezVousCalendarViewState();
}

class _RendezVousCalendarViewState extends State<RendezVousCalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2025, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
    );
  }
}
