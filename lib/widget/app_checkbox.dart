import 'package:api_withgetx/theme/app_color.dart';
import 'package:api_withgetx/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final ValueChanged<bool> onChanged;

  const AppCheckbox({super.key, required this.onChanged});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
      child: Row(
        children: [
          Checkbox(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            fillColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return AppColors.appBlue;
              }
              return Colors.transparent;
            }),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
              widget.onChanged(isChecked);
            },
          ),
          const SizedBox(width: 10),
          Text(
            'I agree to ',
            style: boldBlack.copyWith(fontSize: 15),
          ),
          GestureDetector(
            onTap: () {},
            child: Text(
              'T&C',
              style: boldBlue.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
