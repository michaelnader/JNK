import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/constants.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/widgets/glass/glass_button.dart';
import '../../../../shared/widgets/glass/glass_card.dart';
import '../../../../shared/widgets/glass/glass_chip.dart';
import '../../../../shared/widgets/glass/glass_modal.dart';

/// Shows the date + time picker as a glass bottom sheet. Returns the picked
/// DateTime or null when cancelled.
Future<DateTime?> showDateTimePickerSheet(
  BuildContext context, {
  required DateTime initial,
}) async {
  return GlassModal.show<DateTime>(
    context: context,
    title: 'Pick a date & time',
    heightFactor: 0.7,
    builder: (sheetContext) => _DateTimeSheet(initial: initial),
  );
}

class _DateTimeSheet extends StatefulWidget {
  const _DateTimeSheet({required this.initial});
  final DateTime initial;

  @override
  State<_DateTimeSheet> createState() => _DateTimeSheetState();
}

class _DateTimeSheetState extends State<_DateTimeSheet> {
  late DateTime _date;
  late TimeOfDay _time;

  static const _slots = [
    TimeOfDay(hour: 18, minute: 30),
    TimeOfDay(hour: 19, minute: 0),
    TimeOfDay(hour: 19, minute: 30),
    TimeOfDay(hour: 20, minute: 0),
    TimeOfDay(hour: 20, minute: 30),
    TimeOfDay(hour: 21, minute: 0),
    TimeOfDay(hour: 21, minute: 30),
    TimeOfDay(hour: 22, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    _date = DateTime(widget.initial.year, widget.initial.month, widget.initial.day);
    _time = TimeOfDay.fromDateTime(widget.initial);
  }

  DateTime get _combined =>
      DateTime(_date.year, _date.month, _date.day, _time.hour, _time.minute);

  Future<void> _openDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.charcoal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.xl),
              ),
            ),
            colorScheme: const ColorScheme.dark(
              primary: AppColors.gold,
              onPrimary: AppColors.obsidianDeep,
              surface: AppColors.charcoal,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GlassCard(
          onTap: _openDatePicker,
          padding: const EdgeInsets.all(AppSpacing.lg),
          elevated: false,
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                color: AppColors.gold,
                size: 18,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DATE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.textSecondary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppDateFormat.dayMonth(_date),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          'TIME',
          style: theme.textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: _slots.map((t) {
            final selected = t.hour == _time.hour && t.minute == _time.minute;
            return GlassChip(
              label: t.format(context),
              selected: selected,
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _time = t);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.xl2),
        GlassButton(
          label: 'Set ${AppDateFormat.dayMonth(_date)} at '
              '${_time.format(context)}',
          variant: GlassButtonVariant.gold,
          fullWidth: true,
          onPressed: () => Navigator.of(context).pop(_combined),
        ),
      ],
    );
  }
}
