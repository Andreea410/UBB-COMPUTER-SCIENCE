import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../viewmodels/trip_view_model.dart';

class TripCreatePage extends StatefulWidget {
  const TripCreatePage({super.key});

  @override
  State<TripCreatePage> createState() => _TripCreatePageState();
}

class _TripCreatePageState extends State<TripCreatePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateValidationKey = GlobalKey<FormFieldState>();

  String name = "";
  String destination = "";
  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(const Duration(days: 7));
  double budget = 0;
  String notes = "";

  bool _isDateRangeValid() {
    final startDateOnly = DateTime(start.year, start.month, start.day);
    final endDateOnly = DateTime(end.year, end.month, end.day);
    final isValid = endDateOnly.isAfter(startDateOnly);
    return isValid;
  }

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: start,
      firstDate: DateTime(2000),
      lastDate: end.isAfter(start) 
          ? end.subtract(const Duration(days: 1)) 
          : DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        start = picked;
        _dateValidationKey.currentState?.validate();
      });
    }
  }

  Future<void> _pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: end,
      firstDate: end.isAfter(start) 
          ? start.add(const Duration(days: 1)) 
          : DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        end = picked;
        _dateValidationKey.currentState?.validate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<TripViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                TextFormField(
                  decoration: const InputDecoration(labelText: "Trip Name"),
                  onSaved: (v) => name = v ?? "",
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Destination"),
                  onSaved: (v) => destination = v ?? "",
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),

                const SizedBox(height: 20),

                Text("Start Date", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        start.toLocal().toString().split(' ')[0],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickStartDate,
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Text("End Date", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        end.toLocal().toString().split(' ')[0],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: _pickEndDate,
                    ),
                  ],
                ),

                //     Date validation
                FormField<bool>(
                  key: _dateValidationKey,
                  initialValue: true,
                  validator: (_) {
                    if (!_isDateRangeValid()) {
                      return "End date must be after start date";
                    }
                    return null;
                  },
                  onSaved: (_) {
                    // This ensures the field is part of the form lifecycle
                  },
                  builder: (state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              state.errorText!,
                              style: const TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Total Budget"),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => budget = double.tryParse(v ?? "") ?? 0,
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Notes"),
                  onSaved: (v) => notes = v ?? "",
                ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    child: const Text("Create"),
                    onPressed: () {                      
                      final startDateOnly = DateTime(start.year, start.month, start.day);
                      final endDateOnly = DateTime(end.year, end.month, end.day);
                      
                      final daysDifference = endDateOnly.difference(startDateOnly).inDays;
                                            
                      if (daysDifference <= 0) {
                        _dateValidationKey.currentState?.validate();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("ERROR: End date must be after start date"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 5),
                          ),
                        );
                        return;
                      }
                                            
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      
                      final recheckStart = DateTime(start.year, start.month, start.day);
                      final recheckEnd = DateTime(end.year, end.month, end.day);
                      final recheckDiff = recheckEnd.difference(recheckStart).inDays;
                                            
                      if (recheckDiff <= 0) {
                        debugPrint('DEBUG: Recheck validation FAILED - Blocking save');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("ERROR: End date must be after start date"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 5),
                          ),
                        );
                        return;
                      }
              
                      _formKey.currentState!.save();

                      final newTrip = Trip(
                        id: DateTime.now()
                            .millisecondsSinceEpoch
                            .toString(),
                        name: name,
                        destination: destination,
                        startDate: start,
                        endDate: end,
                        totalBudget: budget,
                        notes: notes,
                      );
                      
                      final tripStartDate = DateTime(newTrip.startDate.year, newTrip.startDate.month, newTrip.startDate.day);
                      final tripEndDate = DateTime(newTrip.endDate.year, newTrip.endDate.month, newTrip.endDate.day);
                      final tripDateDiff = tripEndDate.difference(tripStartDate).inDays;
                                            
                      if (tripDateDiff <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("ERROR: End date must be after start date"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 5),
                          ),
                        );
                        return; 
                      }
                                            
                      vm.addTrip(newTrip);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
