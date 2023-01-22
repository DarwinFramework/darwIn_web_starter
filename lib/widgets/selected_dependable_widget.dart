import 'package:darwin_starter/darwin_starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SelectedDependableWidget extends StatelessWidget {
  final Dependable dependable;

  const SelectedDependableWidget({required this.dependable, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          title: Text(dependable.name, style: text.titleSmall,),
          subtitle: MarkdownBody(data: dependable.description),
        ),
      ],
    );
  }
}
