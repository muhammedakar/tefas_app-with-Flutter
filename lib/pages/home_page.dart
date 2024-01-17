import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tefas_app/ads/widget/banner_widget.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/mixin/home_page_mix.dart';
import 'package:tefas_app/widgets/currency_wid.dart';
import 'package:tefas_app/widgets/float_button.dart';
import 'package:tefas_app/widgets/pie_chart_wid.dart';
import 'package:tefas_app/widgets/portfolio_wid.dart';
import 'package:tefas_app/widgets/top_risers_wid.dart';
import 'package:tefas_app/widgets/total_result.dart';
import '../models/gheet_data_model.dart';
import '../models/locale_data_model.dart';
import '../widgets/drawer_wid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMix {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataGsheets.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DataGsheetsData>? result = snapshot.data;
            return Scaffold(
              drawer: const DrawerWid(),
              floatingActionButton: FloatButtonWid(result: result),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(builder: (context) {
                      return GestureDetector(
                          onTap: () => Scaffold.of(context).openDrawer(),
                          child: SvgPicture.asset(
                            'assets/images/menu.svg',
                            color: Clr.primary,
                          ));
                    }),
                    Text(
                      'FON PORTFÖY',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              fontWeight: FontWeight.bold, color: Clr.primary),
                    ),
                    SvgPicture.asset(
                      'assets/images/menu.svg',
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              body: FutureBuilder(
                  future: localService.getAllList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<LocaleDataModel>? portfolio = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const BannerAdWid(),
                            SizedBox(
                              height: 350.h,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  CurrencyWid(
                                    data: result!,
                                  ),
                                  Expanded(
                                      child: PageView(
                                    onPageChanged: (value) => setState(() {
                                      currentPage = value;
                                    }),
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Clr.primary.shade50,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: PieChartWid(
                                          portfolio: portfolio!,
                                          result: result,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: TotalResult(
                                          result: result,
                                          portfolio: portfolio,
                                        ),
                                      ),
                                    ],
                                  )),
                                  SizedBox(
                                    height: 10,
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: buildIndicator(),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const TabBar(tabs: [
                              Text('Portföyüm'),
                              Text('Yükselenler'),
                              Text('Düşenler'),
                            ]),
                            Expanded(
                              child: TabBarView(children: [
                                PortfolioWid(
                                  result: result,
                                  portfolio: portfolio,
                                ),
                                TopRisersWid(result: result, sort: true),
                                TopRisersWid(result: result, sort: false),
                              ]),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
            );
          } else {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
