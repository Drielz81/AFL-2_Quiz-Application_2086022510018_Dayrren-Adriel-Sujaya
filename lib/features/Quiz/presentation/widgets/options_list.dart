import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/option_tile.dart';

class OptionsList extends StatelessWidget {
  const OptionsList({
    super.key,
    required this.options,
    required this.correctIndex,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<String> options;
  final int correctIndex;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  bool get _answered => selectedIndex != null;

  OptionStatus _statusOf(int i) {
    if (!_answered) return OptionStatus.idle;
    if (i == selectedIndex) {
      return i == correctIndex ? OptionStatus.correct : OptionStatus.wrong;
    }
    if (i == correctIndex) return OptionStatus.revealedCorrect;
    return OptionStatus.locked;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          OptionTile(
            index: i,
            label: options[i],
            status: _statusOf(i),
            onTap: _answered ? null : () => onSelect(i),
          ),
        ],
      ],
    );
  }
}
