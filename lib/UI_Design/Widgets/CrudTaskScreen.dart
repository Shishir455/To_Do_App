import 'package:flutter/material.dart';

class CrudTaskScreen extends StatelessWidget {
  final String tittle;
  final int number;
  const CrudTaskScreen({
    required this.tittle,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blue.shade50,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                number.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                tittle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
