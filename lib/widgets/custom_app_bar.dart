import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final double height;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leading ?? const SizedBox(width: 48),
            if (title != null)
              Expanded(
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            else
              const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: actions ?? [const SizedBox(width: 48)],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
