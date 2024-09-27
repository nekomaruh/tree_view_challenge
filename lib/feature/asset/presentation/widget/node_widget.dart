import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/colors/app_colors.dart';

class NodeWidget extends StatelessWidget {
  final String title;
  final Widget leading;
  final Widget? trailing;
  final bool expanded;
  final int depth;

  const NodeWidget({
    super.key,
    required this.title,
    required this.leading,
    this.trailing,
    required this.expanded,
    required this.depth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 10,
          ),
          for (int i = 0; i < depth - 1; i++) ...[
            const SizedBox(width: 15),
            Container(
              width: 1,
              height: 30,
              color: AppColors.border,
            ),
          ],
          if (expanded) ...[
            SizedBox(
              width: 30,
              child: SvgPicture.asset(
                "assets/icons/down.svg",
                width: 10,
                height: 10,
              ),
            )
          ],
          if (!expanded && depth != 1) ...[
            Container(
              width: 20,
              height: 1,
              color: AppColors.border,
            ),
            const SizedBox(width: 9) // Sub hijos sin nodos
          ],
          leading,
          const SizedBox(width: 8), // NO modificar
          Flexible(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 6), trailing!],
        ],
      ),
    );
  }
}
