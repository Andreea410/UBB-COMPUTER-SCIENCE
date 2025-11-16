import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/trip_view_model.dart';
import 'trip_create_page.dart';
import 'trip_update_page.dart';

class TripListPage extends StatelessWidget {
  const TripListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Trips")),
      body: ListView.builder(
        itemCount: vm.trips.length,
        itemBuilder: (_, index) {
          final trip = vm.trips[index];
          final startDateStr = trip.startDate.toLocal().toString().split(' ')[0];
          final endDateStr = trip.endDate.toLocal().toString().split(' ')[0];
          
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              title: Text(
                trip.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(trip.destination),
                  const SizedBox(height: 4),
                  Text(
                    '$startDateStr - $endDateStr',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TripUpdatePage(trip: trip)),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Trip"),
                          content: Text("Remove ${trip.name}?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                vm.deleteTrip(trip.id);
                                Navigator.pop(context);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TripUpdatePage(trip: trip)),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TripCreatePage()),
          );
        },
      ),
    );
  }
}
