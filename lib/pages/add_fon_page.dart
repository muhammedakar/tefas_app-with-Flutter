import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:searchable_paginated_dropdown/searchable_paginated_dropdown.dart';
import 'package:tefas_app/ads/widget/banner_widget.dart';
import 'package:tefas_app/constants/color_constant.dart';
import 'package:tefas_app/mixin/add_page.dart';

import '../ads/rewardedAd.dart';
import '../models/gheet_data_model.dart';

class AddFonPage extends ConsumerStatefulWidget {
  final List<DataGsheetsData> list;
  const AddFonPage({super.key, required this.list});

  @override
  ConsumerState<AddFonPage> createState() => _AddFonPageState();
}

class _AddFonPageState extends ConsumerState<AddFonPage> with AddFonPageMix {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Clr.primary.shade50,
        title: Text(
        'Fon Ekle',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Clr.primary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: BannerAdWid()),
                Text(
                  'Fon Bilgileri:',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold, color: Clr.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Fon Adı:",
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  child: SearchableDropdown(
                    trailingClearIcon: Container(),
                    value: ilkDeger,
                    isDialogExpanded: true,
                    isEnabled: true,
                    margin: const EdgeInsets.all(15),
                    items: widget.list
                        .map((e) => SearchableDropdownMenuItem(
                              label: e.fonKodu!,
                              onTap: () => kod = e.fonKodu,
                              value: e.fonAdi,
                              child: Text(
                                "${e.fonKodu!}: ${e.fonAdi!}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      ilkDeger = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Alış Fiyatı:'),
                textformWid(price),
                const SizedBox(
                  height: 20,
                ),
                const Text('Dolar Alış Kuru:'),
                textformWid(dolar),
                const SizedBox(
                  height: 20,
                ),
                const Text('Adet:'),
                textformWid(count),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      if (ref.watch(rewardAd.state).state == 0) {
                        rewardedAds.rewardedShow();
                        ref.read(rewardAd.state).state++;
                      } else {
                        ref.read(rewardAd.state).state = 0;
                      }
                      saveButton();
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Clr.primary,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          'Kaydet',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Clr.primary.shade50,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
