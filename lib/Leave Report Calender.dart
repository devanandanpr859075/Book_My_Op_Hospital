import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderRangePicker extends StatefulWidget {
  final String doctorId;

  CalenderRangePicker({required this.doctorId});

  @override
  _CalenderRangePickerState createState() => _CalenderRangePickerState();
}

class _CalenderRangePickerState extends State<CalenderRangePicker> {
  late DateTime _startDate;
  late DateTime _endDate;
  Set<DateTime> _leaveDates = {};
  final int _maxLeaveDays = 5;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now();
    _fetchLeaveDates();
  }

  Future<void> _fetchLeaveDates() async {
    try {
      DocumentSnapshot doctorSnapshot =
      await FirebaseFirestore.instance.collection('doctors').doc(widget.doctorId).get();
      if (doctorSnapshot.exists) {
        Map<String, dynamic> data = doctorSnapshot.data() as Map<String, dynamic>;
        if (data['leaveDates'] != null) {
          Map<String, dynamic> leaveDates = Map<String, dynamic>.from(data['leaveDates']);
          setState(() {
            _leaveDates = leaveDates.keys.map((dateString) {
              List<String> dateParts = dateString.split('-');
              return DateTime(
                int.parse(dateParts[0]),
                int.parse(dateParts[1]),
                int.parse(dateParts[2]),
              );
            }).toSet();
          });
        }
      }
    } catch (e) {
      print("Error fetching leave dates: $e");
    }
  }

  Future<void> updateLeaveDates() async {
    try {
      if (_leaveDates.length > _maxLeaveDays) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You can select a maximum of $_maxLeaveDays days")));
        return;
      }
      Map<String, dynamic> updatedLeaveDates = {};
      for (var date in _leaveDates) {
        updatedLeaveDates['${date.year}-${date.month}-${date.day}'] = 'leave';
      }

      await FirebaseFirestore.instance.collection('doctors').doc(widget.doctorId).update({
        'leaveDates': updatedLeaveDates,
        'isOnLeave': true,

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Leave Dates Updated")));
      _fetchLeaveDates();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to update leave dates")));
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_leaveDates.contains(selectedDay)) {
        _leaveDates.remove(selectedDay);
      } else {
        if (_leaveDates.length < _maxLeaveDays) {
          _leaveDates.add(selectedDay);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You can only select $_maxLeaveDays days.")));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    DateTime firstDayOfMonth = DateTime(currentDate.year, currentDate.month, 1);

    DateTime lastDayOfNextMonth = DateTime(currentDate.year, currentDate.month + 2, 0);

    return Column(
      children: [
        TableCalendar(
          focusedDay: _startDate,
          firstDay: firstDayOfMonth,
          lastDay: lastDayOfNextMonth,
          selectedDayPredicate: (day) {
            return _leaveDates.contains(day);
          },
          onDaySelected: _onDaySelected,
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            defaultDecoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            holidayDecoration: BoxDecoration(
              color: Colors.red, // Mark leave dates with a red color
              shape: BoxShape.circle,
            ),
          ),
          eventLoader: (day) {
            if (_leaveDates.contains(day)) {
              return [day.toString()];
            }
            return [];
          },
          availableGestures: AvailableGestures.none,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Dates: ${_leaveDates.length}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            updateLeaveDates();
          },
          child: Text('Update Leave Dates'),
        ),
      ],
    );
  }
}
