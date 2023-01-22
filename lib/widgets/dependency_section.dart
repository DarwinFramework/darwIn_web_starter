import 'package:darwin_starter/darwin_starter.dart';
import 'package:flutter/material.dart';

import 'dependable_widget.dart';

class DependencySection extends StatelessWidget {

  final String category;
  final List<MapEntry<String, Dependable>> dependables;

  const DependencySection({required this.category, required this.dependables, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 8,),
        const Divider(),
        const SizedBox(height: 8,),
        Container(color: Colors.indigo, padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16), child: Text(category.toUpperCase(), style: text.titleSmall!.copyWith(color: Colors.white)),),
        const SizedBox(height: 8,),
        Wrap(
          runSpacing: 16, spacing: 16,
          children: dependables.map((e) => DependableWidget(id: e.key, dependable: e.value,)).toList(),
        ),
        const SizedBox(height: 8,),
      ],
    );
  }
}
