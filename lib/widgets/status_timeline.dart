import 'package:flutter/material.dart';

import 'status_badge.dart';

class StatusTimeline extends StatelessWidget {
  const StatusTimeline({super.key, required this.status});

  final String status;

  double get _progress {
    return switch (status) {
      'Completed' || 'Cancelled' => 1,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = statusColor(status);
    final isBooked = status == 'Booked';
    final isCompleted = status == 'Completed';
    final isCancelled = status == 'Cancelled';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trip Timeline',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 18),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: _progress),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          builder: (context, progress, _) {
            return Column(
              children: [
                Row(
                  children: [
                    _TimelineStep(
                      label: 'Booked',
                      isActive: isBooked,
                      isReached: true,
                      color: isBooked ? activeColor : statusColor('Booked'),
                    ),
                    Expanded(
                      child: _TimelineLine(
                        fillPercent: progress,
                        color: activeColor,
                      ),
                    ),
                    _TimelineStep(
                      label: 'Completed',
                      isActive: isCompleted,
                      isReached: isCompleted,
                      color: statusColor('Completed'),
                    ),
                    Expanded(
                      child: _TimelineLine(
                        fillPercent: progress,
                        color: activeColor,
                      ),
                    ),
                    _TimelineStep(
                      label: 'Cancelled',
                      isActive: isCancelled,
                      isReached: isCancelled,
                      color: statusColor('Cancelled'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.isActive,
    required this.isReached,
    required this.color,
  });

  final String label;
  final bool isActive;
  final bool isReached;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final fillColor = isActive || isReached ? color : Colors.transparent;
    final borderColor = isActive || isReached ? color : Colors.grey.shade400;
    final iconColor = isActive || isReached ? Colors.white : Colors.grey;

    return SizedBox(
      width: 76,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: fillColor,
              shape: BoxShape.circle,
              border: Border.all(color: borderColor, width: 2),
            ),
            child: Icon(Icons.check, size: 18, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: isActive
                  ? color
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineLine extends StatelessWidget {
  const _TimelineLine({required this.fillPercent, required this.color});

  final double fillPercent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: fillPercent.clamp(0, 1),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}
