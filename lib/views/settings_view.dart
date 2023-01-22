import 'package:darwin_starter/darwin_starter.dart';
import 'package:darwin_web_starter/blocs/settings_cubit.dart';
import 'package:darwin_web_starter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);

  final TextEditingController nameEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var text = Theme.of(context).textTheme;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildApplicationNameField(text),
            const SizedBox(height: 16,),
            Text("Project Type", style: text.titleSmall,),
            _buildProjectTypeSelection(state)
          ],
        );
      },
    );
  }

  TextField _buildApplicationNameField(TextTheme text) {
    return TextField(
            decoration: InputDecoration(
                labelText: "Application Name",
                labelStyle: text.titleSmall
            ),
            onChanged: (s) {
              settings.setName(s);
            },
          );
  }

  Row _buildProjectTypeSelection(SettingsState state) {
    return Row(
            children: [
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: Radio<ProjectType>(
                    value: ProjectType.rest,
                    groupValue: state.type,
                    onChanged: (value) {
                      settings.setType(value??ProjectType.rest);
                    },
                  ),
                  title: const Text("REST"),
                ),
              ),
              SizedBox(
                width: 160,
                child: ListTile(
                  leading: Radio<ProjectType>(
                    value: ProjectType.console,
                    groupValue: state.type,
                    onChanged: (value) {
                      settings.setType(value??ProjectType.rest);
                    },
                  ),
                  title: const Text("Console"),
                ),
              )
            ],
          );
  }
}
