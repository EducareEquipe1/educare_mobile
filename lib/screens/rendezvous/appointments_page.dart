import 'package:flutter/material.dart';
import 'calendar_view.dart';
import 'appointment_list.dart';
import 'requests_list.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  bool _showAppointments = true;
  String _selectedView = 'calendar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/dark_logo.png', height: 40),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2F9F5),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/default_pic.png',
                      ),
                      radius: 20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAFC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: PopupMenuButton<String>(
                      offset: const Offset(0, 45),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              _showAppointments
                                  ? const Color(0xFF679294)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Mes Rendez-vous',
                              style: TextStyle(
                                color:
                                    _showAppointments
                                        ? Colors.white
                                        : const Color(0xFF679294),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color:
                                  _showAppointments
                                      ? Colors.white
                                      : const Color(0xFF679294),
                            ),
                          ],
                        ),
                      ),
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: 'calendar',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color:
                                        _selectedView == 'calendar'
                                            ? const Color(0xFF679294)
                                            : Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Calendrier',
                                    style: TextStyle(
                                      color:
                                          _selectedView == 'calendar'
                                              ? const Color(0xFF679294)
                                              : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'list',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.list,
                                    color:
                                        _selectedView == 'list'
                                            ? const Color(0xFF679294)
                                            : Colors.grey,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Liste',
                                    style: TextStyle(
                                      color:
                                          _selectedView == 'list'
                                              ? const Color(0xFF679294)
                                              : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                      onSelected: (value) {
                        setState(() {
                          _showAppointments = true;
                          _selectedView = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          () => setState(() {
                            _showAppointments = false;
                          }),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color:
                              !_showAppointments
                                  ? const Color(0xFF679294)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Mes Demandes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                !_showAppointments
                                    ? Colors.white
                                    : const Color(0xFF679294),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  _showAppointments
                      ? _selectedView == 'calendar'
                      
                          ? const RendezVousCalendarView()
                          : const AppointmentList()
                      : const RequestsList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAppointmentRequestDialog(context),
        backgroundColor: const Color(0xFF679294),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAppointmentRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
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
                    onPressed: () => Navigator.pop(context),
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
        );
      },
    );
  }
}
