import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tefas_app/constants/color_constant.dart';

class MarkDownPage extends StatefulWidget {
  final String title;
  final String markDown;
  const MarkDownPage(this.title, this.markDown, {super.key});

  @override
  State<MarkDownPage> createState() => _MarkDownPageState();
}

class _MarkDownPageState extends State<MarkDownPage> {
  String _markdownData = '';

  Future<String> getStringInsideFile() async {
    return await rootBundle.loadString(widget.markDown);
  }

  @override
  void initState() {
    getStringInsideFile().then((value) {
      setState(() {
        _markdownData = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: Clr.primary, fontWeight: FontWeight.bold),
        ),
      ),
      body: Markdown(
        data: _markdownData,
      ),
    );
  }
}
