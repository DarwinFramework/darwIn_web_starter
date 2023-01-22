import 'package:darwin_web_starter/blocs/catalog_cubit.dart';
import 'package:darwin_web_starter/blocs/dependency_selection_cubit.dart';
import 'package:darwin_web_starter/views/dependency_explorer.dart';
import 'package:darwin_web_starter/widgets/dependable_widget.dart';
import 'package:darwin_web_starter/widgets/selected_dependable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DependencySelection extends StatelessWidget {
  const DependencySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Theme
        .of(context)
        .textTheme;
    var catalog = Provider.of<CatalogCubit>(context, listen: false);
    var catalogState = catalog.state as CatalogLoaded;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text("Dependencies", style: text.headlineSmall,),
            const Spacer(),
            ElevatedButton(onPressed: () {
              showDialog(context: context, builder: (context) => Dialog(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1024),
                    child: const DependencyExplorer(),
                  )
              ));
            }, child: const Text("Manage"))
          ],
        ),
        BlocBuilder<DependencySelectionCubit, DependencySelectionState>(
          builder: (context, state) {
            if (state.selected.isEmpty) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 96.0),
                child: Text("No dependencies selected.\nYou can view the dependency explorer by pressing on 'Manage'."),
              );
            }

            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2 / 1,
              children: catalogState.dependables.entries
                  .where((e) => state.selected.contains(e.key))
                  .map((e) => SelectedDependableWidget(dependable: e.value))
                  .toList(),
            );
          },
        )
      ],
    );
  }
}
