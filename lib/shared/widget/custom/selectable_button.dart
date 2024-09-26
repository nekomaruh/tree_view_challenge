import 'package:flutter/material.dart';

import '../../../core/theme/colors/app_colors.dart';

class SelectableButton extends StatelessWidget {
  final bool selected;
  final Function(bool) onSelected;
  final Widget? icon;
  final String text;

  const SelectableButton({
    super.key,
    required this.selected,
    required this.onSelected,
    this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: 1,
        ),
        color: selected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(3),
        color: selected ? AppColors.primary : Colors.transparent,
        child: InkWell(
          customBorder: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(3),
          onTap: () {
            onSelected(!selected);
          },
          splashColor: AppColors.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 14,
              right: 16,
              top: 6,
              bottom: 6,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        selected ? AppColors.white : AppColors.unselected,
                        BlendMode.srcATop,
                      ),
                      child: icon,
                    ),
                  ),
                  const SizedBox(width: 6)
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: selected ? AppColors.white : AppColors.unselected,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
