import 'package:flutter/material.dart';
import 'package:test_1/core/widgets/custom_drawer.dart';

class HelpFeedbackItem {
  final String id;
  late final String status;
  final String message;

  HelpFeedbackItem({
    required this.id,
    required this.status,
    required this.message,
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
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Feedback Tracker'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
            Tab(text: 'On Hold'),
            Tab(text: 'Not Reviewed'),
          ],
        ),
      ),
      drawer: CustomDrawerWidget(),
      body: TabBarView(
        children: [
          FeedbackList(status: 'Approved'),
          FeedbackList(status: 'Rejected'),
          FeedbackList(status: 'On Hold'),
          FeedbackList(status: 'Not Reviewed'),
        ],
      ),
    );
  }
}

class FeedbackList extends StatefulWidget {
  final String status;

  const FeedbackList({required this.status});

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {
  List<HelpFeedbackItem> _feedbackList = [];

  @override
  void initState() {
    super.initState();
    _loadFeedbackData();
  }

  void _loadFeedbackData() {
    // Replace this with actual data fetching logic based on widget.status
    // Example: Fetch feedback items where status == widget.status
    // For demonstration purposes, I'm using dummy data
    _feedbackList = [
      HelpFeedbackItem(id: '1', status: 'Approved', message: 'Message 1'),
      HelpFeedbackItem(id: '2', status: 'Rejected', message: 'Message 2'),
      HelpFeedbackItem(id: '3', status: 'On Hold', message: 'Message 3'),
      HelpFeedbackItem(id: '4', status: 'Not Reviewed', message: 'Message 4'),
    ];
  }

  void _performAction(String itemId, String action) {
    // Replace this with actual action handling logic
    // Update the status of the feedback item with id == itemId
    setState(() {
      HelpFeedbackItem itemToUpdate =
          _feedbackList.firstWhere((item) => item.id == itemId);
      itemToUpdate.status = action;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  _performAction(item.id, 'Approved');
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
