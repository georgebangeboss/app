import 'package:find_my_id/routes/routes.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, RouteManager.home);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd0e7ec),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "KSB ",
                    children: [
                      TextSpan(
                        text: 'Supreme ',
                        style: TextStyle(),
                      ),
                      const TextSpan(
                        text: 'Serv',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
