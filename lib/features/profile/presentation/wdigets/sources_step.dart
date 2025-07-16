import 'package:ewallet/core/extensions/money_extension.dart';
import 'package:ewallet/features/profile/presentation/wdigets/create_source_dialog.dart';
import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SourcesStep extends StatelessWidget {
  final List<Source> sources;
  final ValueChanged<Source> onSourceAdded;

  const SourcesStep({
    super.key,
    required this.sources,
    required this.onSourceAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...sources.map(
          (source) => ListTile(
            title: Text(source.name),
            trailing: Text(source.money.format()),
          ),
        ),
        IconButton(
          onPressed: () async {
            final newSource = await showDialog<Source>(
              context: context,
              builder: (context) => CreateSourceDialog(),
            );
            if (newSource != null) {
              onSourceAdded(newSource);
            }
          },
          icon: Icon(FontAwesomeIcons.plus),
        ),
      ],
    );
  }
}
