import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constant.dart';
import '../pages/markdown_page.dart';

class DrawerWid extends StatefulWidget {
  const DrawerWid({super.key});

  @override
  State<DrawerWid> createState() => _DrawerWidState();
}

class _DrawerWidState extends State<DrawerWid> {
  Future<void> _writeEamil(String email) async {
    print('Trying to send email to: $email');
    try {
      final Uri launchUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      await launchUrl(launchUri);
    } catch (e) {
      print('Error launching email: $e');
      // Diğer hata ayıklama adımlarını buraya ekleyebilirsiniz.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Clr.primary.shade50,
      child: SafeArea(
        child: Column(
          children: [
            Text(
              'Fon Portföy',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Clr.primaryAccent.shade700,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(
                    overscroll: false,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 50.h),
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.home_outlined,
                          color: Clr.primaryAccent.shade700,
                        ),
                        title: Text(
                          'Ana Sayfa',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Clr.primaryAccent.shade700),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                      // ListTile(
                      //     leading: Icon(
                      //       Icons.question_mark_outlined,
                      //       color: Clr.primary.shade50,
                      //     ),
                      //     title: Text(
                      //       Str.curiousThing,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .titleLarge!
                      //           .copyWith(color: Clr.primary.shade50),
                      //     ),
                      //     onTap: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => const MarkDownPage(
                      //                   Str.faq, Pth.privacyMarkDown)));
                      //     }),
                      ListTile(
                        leading: Icon(
                          Icons.star_outline,
                          color: Clr.primaryAccent.shade700,
                        ),
                        title: Text(
                          'Uygulamayı puanla',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Clr.primaryAccent.shade700),
                        ),
                        onTap: () {
                          String link;
                          if (Platform.isIOS) {
                            link =
                                'https://apps.apple.com/tr/app/fon-portf%C3%B6y/id6472076131?l=tr';
                          } else {
                            link =
                                'https://play.google.com/store/apps/details?id=com.mrakar.tefas_app';
                          }

                          launchUrl(
                            Uri.parse(link),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.shield_outlined,
                          color: Clr.primaryAccent.shade700,
                        ),
                        title: Text(
                          'Gizlilik ve Politika',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Clr.primaryAccent.shade700),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MarkDownPage(
                                      'Gizlilik ve Politika',
                                      'assets/privacy.md')));
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.share_outlined,
                          color: Clr.primaryAccent.shade700,
                        ),
                        title: Text(
                          'Uygulamayı Paylaş',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Clr.primaryAccent.shade700),
                        ),
                        onTap: () {
                          String link;
                          if (Platform.isIOS) {
                            link =
                                'https://apps.apple.com/tr/app/fon-portf%C3%B6y/id6472076131?l=tr';
                          } else {
                            link =
                                'https://play.google.com/store/apps/details?id=com.mrakar.tefas_app';
                          }
                          Share.share(link);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.mail_outline,
                          color: Clr.primaryAccent.shade700,
                        ),
                        title: Text(
                          'İletişim',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Clr.primaryAccent.shade700),
                        ),
                        onTap: () {
                          _writeEamil('mr.akar05@gmail.com');
                        },
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
