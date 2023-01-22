import 'package:darwin_starter/darwin_starter.dart';
import 'package:darwin_web_starter/blocs/catalog_cubit.dart';
import 'package:darwin_web_starter/main.dart';
import 'package:darwin_web_starter/views/dependency_selection.dart';
import 'package:darwin_web_starter/widgets/dependency_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class DependencyExplorer extends StatelessWidget {
  const DependencyExplorer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;

    var catalogState = catalog.state as CatalogLoaded;
    Map<String, List<MapEntry<String, Dependable>>> categories = {};
    catalogState.dependables.forEach((key, value) {
      var list = categories[value.category]??<MapEntry<String, Dependable>>[];
      list.add(MapEntry(key, value));
      categories[value.category] = list;
    });

    return Column(
      children: [
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text("Dependency Explorer", style: text.headlineSmall!.copyWith(fontWeight: FontWeight.bold),),
              Spacer(),
              CloseButton()
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: categories.entries.map((e) => DependencySection(category: e.key, dependables: e.value)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
