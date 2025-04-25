import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_api_app/API/Service/Network_Client.dart';
import 'package:todo_api_app/API/utils/Urls.dart';

class AllScreenCard extends StatefulWidget {
  final String taskId;
  final String title;
  final String status;
  final Color color;
  final DateTime dateTime;
  final String subtitle;

  const AllScreenCard({
    required this.taskId,
    required this.dateTime,
    required this.status,
    required this.title,
    required this.subtitle,
    required this.color,
    super.key,
  });

  @override
  State<AllScreenCard> createState() => _AllScreenCardState();
}

class _AllScreenCardState extends State<AllScreenCard> {
  bool isLoading = false;
  late String currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus=widget.status;
  }

  Future<void> _changeTaskStatus(String status) async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkClient().getRequest(
      url: Urls.updateTaskStatus(widget.taskId, status),
    );

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      setState(() {
        currentStatus = status;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated to $status')),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update status')),
      );
    }
  }
  Future<void> _DeleteTask() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkClient().getRequest(
      url: Urls.deleteTask(widget.taskId),
    );

    setState(() {
      isLoading = false;
    });

    if (response.isSuccess) {
      setState(() {
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task Deleted ')),
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to Delete Task')),
      );
    }
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Status"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildStatusTile("New", Colors.green),
              _buildStatusTile("Progress", Colors.orange),
              _buildStatusTile("Completed", Colors.blue),
              _buildStatusTile("Cancel", Colors.red),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusTile(String status, Color iconColor) {
    bool isAllowed = false;

    if (currentStatus == "New") {
      isAllowed =
          status == "Progress" || status == "Completed" || status == "Cancel";
    } else if (currentStatus == "Progress") {
      isAllowed = status == "Completed" || status == "Cancel";
    } else {
      isAllowed = false;
    }

    return ListTile(
      onTap: isAllowed
          ? () {
        if (currentStatus != status) {
          _changeTaskStatus(status);
        }
      }
          : null,
      title: Text(
        status,
        style: TextStyle(
          color: isAllowed ? Colors.black : Colors.grey,
        ),
      ),
      trailing: currentStatus == status
          ? Icon(Icons.done, color: iconColor)
          : isAllowed
          ? null
          : const Icon(Icons.block, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.dateTime);

    return Card(
      color: Colors.blue.shade50,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.bodyMedium),
            Text(widget.subtitle,
                style: Theme.of(context).textTheme.titleSmall),
            Text(formattedDate, style: Theme.of(context).textTheme.titleSmall),
            Row(
              children: [
                Chip(
                  label: Text(currentStatus),
                  backgroundColor: widget.color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: isLoading ? null : _showDialog,
                  icon: Icon(Icons.edit, color: Colors.green),
                ),
                IconButton(
                  onPressed: isLoading ? null : _DeleteTask,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}  