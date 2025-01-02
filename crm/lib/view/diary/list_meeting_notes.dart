import 'package:crm/db/meeting.dart';
import 'package:flutter/material.dart';

import '../../function/repository/meeting_repository.dart';
import '../../utils/app_theme_constant.dart';
import '../../utils/app_widget_constant.dart';

class ListMeetingNotes extends StatefulWidget {
  const ListMeetingNotes({super.key});

  @override
  State<ListMeetingNotes> createState() => _ListMeetingNotesState();
}

class _ListMeetingNotesState extends State<ListMeetingNotes> {
  String search = '';
  MeetingRepository meetingRepository = MeetingRepository();
  List<MeetingNote> meetingList = [];

  @override
  void initState() {
    super.initState();
    getMeeting();
  }

  Future<void> getMeeting() async {
    try {
      meetingList = await meetingRepository.getMeetingByUser();
      print("meeting: ${meetingList[0].start_time}");
    } catch (e) {
      showToastError(context, e.toString());
    } finally {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.grey,
      appBar: AppBar(
        backgroundColor: AppTheme.redMaroon,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: AppTheme.padding3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                backButton(context),
              ],
            ),
            const Padding(
              padding: AppTheme.padding3,
              child: Text(
                'Meeting Notes',
                style: AppTheme.titleFont,
              ),
            ),
            searchBar(search),
            AppTheme.box10,
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Today',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            AppTheme.divider,
            generateMeetingNotes(day: 'today'),
            AppTheme.box30,
            const Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'Yesterday',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            AppTheme.divider,
            generateMeetingNotes(day: 'yesterday'),
          ],
        ),
      ),
    );
  }

  Widget searchBar(String search) {
    return Padding(
      padding: AppTheme.padding10,
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
          decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget generateMeetingNotes({required String day}) {
    List<MeetingNote> filteredMeetings = meetingList.where((meeting) {
      DateTime meetingDate = DateTime.parse(meeting.start_time).toLocal();
      DateTime now = DateTime.now();

      if (day == 'today') {
        return isSameDate(meetingDate, now);
      } else if (day == 'tomorrow') {
        return isSameDate(meetingDate, now.add(const Duration(days: 1)));
      }
      return false;
    }).toList();

    if (filteredMeetings.isEmpty) {
      return const Center(
        child: Text(
          "No meetings found.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: filteredMeetings.length,
      itemBuilder: (context, index) {
        final meeting = filteredMeetings[index];

        return ListTile(
          title: Text(
            "${meeting.title}",
            style: AppTheme.listTileFont,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${formatDateTime(meeting.start_time)} - ${formatDateTime(meeting.end_time)}"),
              Text(meeting.location),
            ],
          ),
        );
      },
    );
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
