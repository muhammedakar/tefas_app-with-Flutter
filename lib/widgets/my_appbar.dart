import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tefas_app/constants/app_constants.dart';
import 'package:tefas_app/service/locale_service.dart';

import '../models/gheet_data_model.dart';

class MyAppBar extends StatelessWidget {
  final List<DataGsheetsData> list;
  const MyAppBar({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 0.16.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage(AppConstants.memojiPath)),
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.white.withOpacity(0.7)),
              ),
            ),
            Expanded(
              flex: 8,
              child: Center(
                child: AutoSizeText(
                  AppConstants.appbarTitle,
                  style: AppConstants.titleTs,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: Colors.white.withOpacity(0.7)),
                child: Center(
                  child: IconButton(
                    onPressed: () => LocalService.alertDialog(list, context),
                    icon: const Icon(Icons.add,
                        size: 35, color: AppConstants.primaryColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
