import 'package:flutter/material.dart';

class CustomPopUp extends StatefulWidget {
  final String title;
  final Function() onTap;

  const CustomPopUp({super.key, required this.title, required this.onTap});

  @override
  State<CustomPopUp> createState() => _CustomPopUpState();
}

class _CustomPopUpState extends State<CustomPopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(16),
      // insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.red),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onTap();
                  },
                  child: Text(
                    "Yes",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.green),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
