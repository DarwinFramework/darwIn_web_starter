import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:darwin_starter/darwin_starter.dart';
import 'package:darwin_web_starter/blocs/catalog_cubit.dart';
import 'package:darwin_web_starter/main.dart';
import 'package:darwin_web_starter/views/dependency_selection.dart';
import 'package:darwin_web_starter/views/settings_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Initialiser extends StatelessWidget {
  const Initialiser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            BlocBuilder<CatalogCubit, CatalogState>(builder: (context, state) {
          if (state is! CatalogLoaded)
            return const Center(child: CircularProgressIndicator());
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1024),
              child: ListView(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Darwin ",
                        style:
                            text.displaySmall!.copyWith(color: Colors.indigo)),
                    TextSpan(text: "Starter", style: text.displaySmall)
                  ])),
                  const SizedBox(
                    height: 16,
                  ),
                  SettingsView(),
                  const SizedBox(
                    height: 16,
                  ),
                  const DependencySelection(),
                  ElevatedButton(
                      onPressed: () async {
                        print("Selected: ${selection.state.selected.toList()}");
                        var archive = await DarwinStarter.initialize(
                            name: settings.state.name,
                            type: settings.state.type,
                            dependencies: selection.state.selected.toList());
                        var encode = ZipEncoder();
                        var data = Uint8List.fromList(encode.encode(archive)!);
                        await FileSaver.instance.saveFile(
                            settings.state.name, data, "zip",
                            mimeType: MimeType.ZIP);
                      },
                      child: const Text("Generate")),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildFooter()
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Row _buildFooter() {
    return Row(
      children: [
        Text("© 2023 Darwin Framework authors | Apache 2.0 License"),
        Spacer(),
        _buildClickableIcon(EvaIcons.messageCircle, "Discord",
            "https://discord.gg/6HKuGSzYKJ"),
        const SizedBox(width: 4,),
        _buildClickableIcon(EvaIcons.book, "Docs",
            "https://helightdev.gitbook.io/darwin"),
        const SizedBox(width: 4,),
        _buildClickableIcon(EvaIcons.github, "GitHub",
            "https://github.com/DarwinFramework/darwin"),
      ],
    );
  }

  GestureDetector _buildClickableIcon(IconData data, String text, String link) {
    return GestureDetector(
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Tooltip(
              message: text,
              child: Icon(
                data,
                size: 24,
              ))),
      onTap: () => launchUrlString(link),
    );
  }
}
