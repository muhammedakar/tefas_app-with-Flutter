import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tefas_app/constants/app_constants.dart';
import 'package:tefas_app/models/gheet_data_model.dart';
import 'package:tefas_app/service/data_gheets.dart';
import 'package:tefas_app/widgets/my_appbar.dart';
import 'package:tefas_app/widgets/portfolio_wid.dart';
import 'package:tefas_app/widgets/top_risers.dart';
import 'package:tefas_app/widgets/total_result_wid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final DataGsheets _dataGsheets;
  late Future<List<DataGsheetsData>> listData = _dataGsheets.getData();
  bool switchValue = true;
  @override
  void initState() {
    _dataGsheets = DataGsheets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: RefreshIndicator(
        backgroundColor: AppConstants.secondaryColor,
        color: AppConstants.thirdColor,
        strokeWidth: 3,
        onRefresh: _refresh,
        child: SafeArea(
          child: FutureBuilder<List<DataGsheetsData>>(
              future: _dataGsheets.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DataGsheetsData>? result = snapshot.data;

                  return Column(
                    children: [
                      MyAppBar(
                        list: result!,
                      ),
                      Divider(
                        thickness: 4.h,
                        endIndent: 45.w,
                        indent: 45.w,
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 10,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppConstants.titlesText("Bilanço"),
                                  switchBuilder()
                                ],
                              ),
                            ),
                            TotalResultWid(
                                list: result, switchValue: switchValue),
                            PortfolioWid(
                              result: result,
                              switchValue: switchValue,
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: AppConstants.titlesText(
                                    "En çok değerlenenler")),
                            TopRisersWid(result: result, sort: true),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: AppConstants.titlesText(
                                    "En çok değer kaybedenler")),
                            TopRisersWid(result: result, sort: false),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }

  FlutterSwitch switchBuilder() {
    return FlutterSwitch(
      value: switchValue,
      onToggle: (value) => setState(() {
        switchValue = value;
      }),
      activeColor: AppConstants.secondaryColor,
      toggleColor: AppConstants.primaryColor,
      inactiveColor: AppConstants.thirdColor,
      inactiveIcon: Image.asset(
        AppConstants.dollarPath,
        color: Colors.white,
      ),
      activeIcon: Image.asset(
        AppConstants.tlPath,
        color: Colors.white,
        fit: BoxFit.fill,
      ),
    );
  }

  Future<void> _refresh() async {
    return Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => setState(() {}));
  }
}
