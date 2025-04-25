import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'appointment_list.dart';
import 'requests_list.dart';

class RendezVousCalendarView extends StatefulWidget {
  const RendezVousCalendarView({Key? key}) : super(key: key);

  @override
  State<RendezVousCalendarView> createState() => _RendezVousCalendarViewState();
}

class _RendezVousCalendarViewState extends State<RendezVousCalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  bool _showAppointments = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/dark_logo.png', height: 40),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    radius: 20,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => _showAppointments = true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _showAppointments
                                ? const Color.fromRGBO(103, 146, 148, 1)
                                : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Mes Rendez-vous',
                        style: TextStyle(
                          color:
                              _showAppointments
                                  ? Colors.white
                                  : const Color.fromRGBO(103, 146, 148, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          () => setState(() => _showAppointments = false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !_showAppointments
                                ? const Color.fromRGBO(103, 146, 148, 1)
                                : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Mes Demandes',
                        style: TextStyle(
                          color:
                              !_showAppointments
                                  ? Colors.white
                                  : const Color.fromRGBO(103, 146, 148, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TableCalendar(
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
            ),
            if (_selectedDay != null)
              Expanded(
                child:
                    _showAppointments
                        ? const AppointmentList()
                        : const RequestsList(),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAppointmentRequestDialog(),
        backgroundColor: const Color.fromRGBO(103, 146, 148, 1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAppointmentRequestDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Demande de rendez-vous',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Motif de consultation',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      'Ex : J\'ai mal à la gorge depuis quelques jours...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(103, 146, 148, 1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Envoyer la demande',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
