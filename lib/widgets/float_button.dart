import 'package:flutter/material.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/pages/add_fon_page.dart';

class FloatButtonWid extends StatelessWidget {
  const FloatButtonWid({
    super.key,
    required this.result,
  });

  final List<DataGsheetsData>? result;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddFonPage(
                      list: result!,
                    )));
      },
      backgroundColor: Clr.primary,
      isExtended: true,
      label: Row(
        children: [
          Text(
            'Fon Ekle',
            style: TextStyle(
                color: Clr.primary.shade50, fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.add,
            color: Clr.primary.shade50,
          )
        ],
      ),
    );
  }
}
