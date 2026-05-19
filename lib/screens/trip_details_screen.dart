import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip.dart';
import '../providers/trips_provider.dart';
import '../widgets/status_badge.dart';
import '../widgets/status_timeline.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key, required this.tripId});

  final int tripId;

  List<String> _statusOptions(String currentStatus) {
    if (currentStatus == 'Booked') {
      return const ['Booked', 'Completed', 'Cancelled'];
    }

    return [currentStatus];
  }

  void _updateStatus(BuildContext context, String newStatus) {
    context.read<TripsProvider>().updateTripStatus(tripId, newStatus);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Status updated to $newStatus')));
  }

  @override
  Widget build(BuildContext context) {
    final trip = context.watch<TripsProvider>().tripById(tripId);

    if (trip == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Trip Details')),
        body: const Center(child: Text('Trip not found.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Trip Details')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FieldBlock(label: 'Title', value: trip.title),
                  const SizedBox(height: 16),
                  _FieldBlock(label: 'Date', value: trip.date),
                  const SizedBox(height: 16),
                  _FieldBlock(label: 'Pickup location', value: trip.pickup),
                  const SizedBox(height: 16),
                  _FieldBlock(label: 'Drop location', value: trip.drop),
                  const SizedBox(height: 16),
                  Text(
                    'Current Status',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  StatusBadge(status: trip.status),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _StatusControl(
            trip: trip,
            options: _statusOptions(trip.status),
            onChanged: (status) {
              if (status == null || status == trip.status) {
                return;
              }
              _updateStatus(context, status);
            },
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: StatusTimeline(status: trip.status),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }
}

class _FieldBlock extends StatelessWidget {
  const _FieldBlock({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _StatusControl extends StatelessWidget {
  const _StatusControl({
    required this.trip,
    required this.options,
    required this.onChanged,
  });

  final Trip trip;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final isFinal = trip.status == 'Completed' || trip.status == 'Cancelled';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          initialValue: trip.status,
          decoration: const InputDecoration(labelText: 'Change Status'),
          items: options
              .map(
                (status) => DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                ),
              )
              .toList(),
          onChanged: isFinal ? null : onChanged,
        ),
        if (isFinal) ...[
          const SizedBox(height: 10),
          Text(
            'Status is final',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
