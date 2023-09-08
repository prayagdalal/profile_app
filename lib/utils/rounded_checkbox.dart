import 'package:flutter/material.dart';
import 'package:login_module/utils/app_colors.dart';

class RoundedCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const RoundedCheckbox({super.key, required this.value, required this.onChanged});

  @override
  _RoundedCheckboxState createState() => _RoundedCheckboxState();
}

class _RoundedCheckboxState extends State<RoundedCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        width: 16.0,
        height: 16.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.value ? AppColors.black : Colors.transparent,
          border: widget.value ? null : Border.all(color: AppColors.kD0D5DD),
        ),
        child: widget.value ? const Icon(Icons.check, size: 16.0, color: Colors.white) : null,
      ),
    );
  }
}
