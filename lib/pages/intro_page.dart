import 'package:flutter/material.dart';
import 'package:tefas_app/pages/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff004AAD),
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(
              flex: 35,
            ),
            SizedBox(
                height: 300,
                width: 300,
                child: Image.asset("assets/images/FUNDS.png")),
            const Spacer(
              flex: 25,
            ),
            const SafeArea(
                child: Text(
              '@mrakar tarafindan gelistirildi',
              style: TextStyle(color: Colors.white60),
            ))
          ],
        )),
      ),
    );
  }
}
