import 'package:flutter/material.dart';
import '../models/trip.dart';
import 'dart:math';

class TripViewModel extends ChangeNotifier {
  final List<Trip> _trips = [];
  List<Trip> get trips => List.unmodifiable(_trips);

  TripViewModel() {
    _trips.addAll([
      Trip(
        id: "1",
        name: "Paris Adventure",
        destination: "Paris, France",
        startDate: DateTime(2025, 6, 1),
        endDate: DateTime(2025, 6, 8),
        totalBudget: 2500.0,
        notes: "Visit Eiffel Tower, Louvre Museum, and enjoy French cuisine",
      ),
      Trip(
        id: "2",
        name: "Tokyo Exploration",
        destination: "Tokyo, Japan",
        startDate: DateTime(2025, 7, 15),
        endDate: DateTime(2025, 7, 25),
        totalBudget: 3500.0,
        notes: "Explore Shibuya, visit temples, and try authentic sushi",
      ),
      Trip(
        id: "3",
        name: "Beach Getaway",
        destination: "Bali, Indonesia",
        startDate: DateTime(2025, 8, 10),
        endDate: DateTime(2025, 8, 20),
        totalBudget: 2000.0,
        notes: "Relax on beautiful beaches and enjoy tropical paradise",
      ),
    ]);
  }

  void addTrip(Trip trip) {
    _trips.add(trip);
    notifyListeners();
  }

  void updateTrip(Trip updated) {
    final idx = _trips.indexWhere((t) => t.id == updated.id);
    if (idx != -1) {
      _trips[idx] = updated;
      notifyListeners();
    }
  }

  void deleteTrip(String id) {
    _trips.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Trip createEmptyTrip() {
    return Trip(
      id: Random().nextInt(999999).toString(),
      name: "",
      destination: "",
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 7)),
      totalBudget: 0,
      notes: "",
    );
  }
}
