import 'package:darwin_starter/darwin_starter.dart';
import 'package:darwin_web_starter/blocs/dependency_selection_cubit.dart';
import 'package:darwin_web_starter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DependableWidget extends StatefulWidget {
  final String id;
  final Dependable dependable;

  const DependableWidget({required this.id, required this.dependable, Key? key})
      : super(key: key);

  @override
  State<DependableWidget> createState() => _DependableWidgetState();
}

class _DependableWidgetState extends State<DependableWidget> with TickerProviderStateMixin {

  late Animation<double> opacityAnimation;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    opacityAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.value = 1;
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 256, minWidth: 256),
      child: GestureDetector(
        onTap: () => _handleTap(selection.state),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: _buildCardDecoration(selection.state),
            child: _buildContent(text),
          ),
        ),
      ),
    );
  }

  void _handleTap(DependencySelectionState state) async {
    controller.reverse(from: 1);
    await Future.delayed(const Duration(milliseconds: 50));
    if (state.selected.contains(widget.id)) {
      selection.remove(widget.id);
    } else {
      selection.add(widget.id);
    }
    controller.forward(from: 0.25);
  }

  BoxDecoration _buildCardDecoration(DependencySelectionState state) {
    return BoxDecoration(
        color: Colors.white,
        //border: Border.all(color: Colors.black.withOpacity(.08), width: 4),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: state.selected.contains(widget.id)
                  ? Colors.indigo.withOpacity(.66 * opacityAnimation.value)
                  : Colors.black.withOpacity(.12 * opacityAnimation.value),
              offset: const Offset(0, 1.5),
              spreadRadius: 3,
              blurRadius: 3)
        ]);
  }

  Padding _buildContent(TextTheme text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            widget.dependable.name,
            style: text.titleSmall,
          ),
          MarkdownBody(
            data: widget.dependable.description,
          ),
        ],
      ),
    );
  }
}
