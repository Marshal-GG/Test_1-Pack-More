import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../help_feeback_page/bloc/help_feedback_page_bloc.dart';

class HelpFeedbackItem {
  final String id;
  late final String status;
  final String message;
  final String type;

  HelpFeedbackItem({
    required this.id,
    required this.status,
    required this.message,
    required this.type,
  });
}

class HelpFeedbackTrackerPage extends StatefulWidget {
  const HelpFeedbackTrackerPage({super.key});

  @override
  State<HelpFeedbackTrackerPage> createState() =>
      _HelpFeedbackTrackerPageState();
}

class _HelpFeedbackTrackerPageState extends State<HelpFeedbackTrackerPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HelpFeedbackPageBloc, HelpFeedbackPageState>(
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: 1,
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Help & Feedback Tracker'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'New'),
                  Tab(text: 'On Hold'),
                  Tab(text: 'Solved'),
                  Tab(text: 'Rejected'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                FeedbackList(status: 'New'),
                FeedbackList(status: 'On Hold'),
                FeedbackList(status: 'Solved'),
                FeedbackList(status: 'Rejected'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FeedbackList extends StatefulWidget {
  final String status;

  const FeedbackList({required this.status});

  @override
  State<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  List<HelpFeedbackItem> _feedbackList = [];

  @override
  void initState() {
    super.initState();
    _loadFeedbackData();
  }

  void _loadFeedbackData() {
    FirebaseFirestore.instance
        .collectionGroup('help_feedback')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String type = data['type'];
        String message = data['message'];
        String status = data['status'];
        String id = doc.id;

        _feedbackList.add(HelpFeedbackItem(
          id: id,
          status: status,
          message: message,
          type: type,
        ));
      }

      setState(() {
        // Notify the widget to rebuild with the fetched data.
      });
    }).catchError((error) {
      print('Error fetching data: $error');
    });
  }

  void _performAction(String itemId, String action) {
    setState(() {
      // HelpFeedbackItem itemToUpdate =
      //     widget.feedbackItems.firstWhere((item) => item.id == itemId);
      // itemToUpdate.status = action;
      // filterFeedbackList(); // Re-filter the list after updating the status.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter the feedback list based on the selected tab.
    List<HelpFeedbackItem> filteredList =
        _feedbackList.where((item) => item.status == widget.status).toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        HelpFeedbackItem item = filteredList[index];

        return ListTile(
          title: Text(item.message),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _performAction(item.id, 'Solved');
                },
                icon: Icon(Icons.check, color: Colors.green),
              ),
              IconButton(
                onPressed: () {
                  _performAction(item.id, 'Rejected');
                },
                icon: Icon(Icons.close, color: Colors.red),
              ),
              IconButton(
                onPressed: () {
                  _performAction(item.id, 'On Hold');
                },
                icon: Icon(Icons.pause, color: Colors.orange),
              ),
            ],
          ),
        );
      },
    );
  }
}
