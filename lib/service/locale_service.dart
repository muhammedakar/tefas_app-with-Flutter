import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tefas_app/models/locale_data_model.dart';

import '../models/gheet_data_model.dart';
import '../widgets/alert_dialog_wid.dart';

class LocalService {
  late Box<LocaleDataModel> _taskBox;

  LocalService() {
    _taskBox = Hive.box<LocaleDataModel>("portfolio");
  }

  Future<void> addPortfolio(LocaleDataModel localeDataModel) async {
    await _taskBox.put(localeDataModel.id, localeDataModel);
  }

  Future<void> updatePortfolio(
      String id, LocaleDataModel localeDataModel) async {
    await _taskBox.put(id, localeDataModel);
  }

  Future<void> deletePortfolio(String id) async {
    await _taskBox.delete(id);
  }

  Future<List<LocaleDataModel>> getAllList() async {
    return _taskBox.values.toList();
  }

  static alertDialog(List<DataGsheetsData> list,BuildContext context){
    list.sort(
      (a, b) => a.fonKodu!.compareTo(b.fonKodu!),
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWid(
          list: list,
        );
      },
    );
  }
}
