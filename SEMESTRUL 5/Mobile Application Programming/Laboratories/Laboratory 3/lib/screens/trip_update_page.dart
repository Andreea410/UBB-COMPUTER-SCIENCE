import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/trip.dart';
import '../viewmodels/trip_view_model.dart';

class TripUpdatePage extends StatefulWidget {
  final Trip trip;

  const TripUpdatePage({super.key, required this.trip});

  @override
  State<TripUpdatePage> createState() => _TripUpdatePageState();
}

class _TripUpdatePageState extends State<TripUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final _dateValidationKey = GlobalKey<FormFieldState>();

  late String name;
  late String destination;
  late DateTime start;
  late DateTime end;
  late double budget;
  late String notes;

  @override
  void initState() {
    super.initState();
    name = widget.trip.name;
    destination = widget.trip.destination;
    start = widget.trip.startDate;
    end = widget.trip.endDate;
    budget = widget.trip.totalBudget;
    notes = widget.trip.notes;
  }

  bool _isDateRangeValid() {
    // Normalize dates to compare only date part (ignore time)
    final startDateOnly = DateTime(start.year, start.month, start.day);
    final endDateOnly = DateTime(end.year, end.month, end.day);
    return endDateOnly.isAfter(startDateOnly);
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
      appBar: AppBar(title: const Text("Update Trip")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: "Trip Name"),
                  onSaved: (v) => name = v ?? "",
                ),
                TextFormField(
                  initialValue: destination,
                  decoration: const InputDecoration(labelText: "Destination"),
                  onSaved: (v) => destination = v ?? "",
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

                // Date validation
                FormField<bool>(
                  key: _dateValidationKey,
                  initialValue: true,
                  validator: (_) {
                    if (!_isDateRangeValid()) {
                      return "End date must be after start date";
                    }
                    return null;
                  },
                  onSaved: (_) {},
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
                  initialValue: budget.toString(),
                  decoration: const InputDecoration(labelText: "Total Budget"),
                  keyboardType: TextInputType.number,
                  onSaved: (v) => budget = double.tryParse(v ?? "") ?? 0,
                ),
                TextFormField(
                  initialValue: notes,
                  decoration: const InputDecoration(labelText: "Notes"),
                  onSaved: (v) => notes = v ?? "",
                ),

                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text("Update"),
                  onPressed: () {
                    // Validate date range first
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
                    
                    // Validate form
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    
                    // Double-check dates
                    final recheckStart = DateTime(start.year, start.month, start.day);
                    final recheckEnd = DateTime(end.year, end.month, end.day);
                    final recheckDiff = recheckEnd.difference(recheckStart).inDays;
                    
                    if (recheckDiff <= 0) {
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

                    vm.updateTrip(
                      widget.trip.copyWith(
                        name: name,
                        destination: destination,
                        startDate: start,
                        endDate: end,
                        totalBudget: budget,
                        notes: notes,
                      ),
                    );

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
