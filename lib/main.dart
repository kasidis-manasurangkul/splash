import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late double width;
  late double height;
  double opc = 1.0;
  double? titleTopPos;
  double? circleTopPos;

  @override
  void initState() {
    super.initState();

    // Initial size is set to full screen in didChangeDependencies
    WidgetsBinding.instance.addPostFrameCallback((_) {
      titleTopPos = (MediaQuery.of(context).size.height * 0.5) -
          (MediaQuery.of(context).size.width * 0.15 / 2);
      circleTopPos = null;
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        setState(() {
          width = MediaQuery.of(context).size.width * 0.135;
          height = MediaQuery.of(context).size.width * 0.135;
        });
      });
      Future.delayed(const Duration(milliseconds: 1500)).then((value) {
        setState(() {
          opc = 0.0;
        });
      });
      Future.delayed(const Duration(milliseconds: 2500)).then((value) {
        setState(() {
          circleTopPos = MediaQuery.of(context).size.height * 0.5 -
              MediaQuery.of(context).size.width * 0.135 / 2;
        });
      });
      Future.delayed(const Duration(milliseconds: 3500)).then((value) {
        setState(() {
          titleTopPos = -MediaQuery.of(context).size.height;
          circleTopPos = -MediaQuery.of(context).size.height;
        });
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    width = screenSize.height * 2;
    height = screenSize.height * 2;
  }

  @override
  void dispose() {
    // Dispose of the animation controller to release resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.sizeOf(context).width;
    double scrHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: scrWidth,
            height: scrHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  top: titleTopPos,
                  child: Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/titleblack.png"),
                    ),
                  )),
                ),
                AnimatedPositioned(
                  duration: const Duration(seconds: 2),
                  top: circleTopPos,
                  left: (scrWidth / 2 - width / 2) +
                      MediaQuery.of(context).size.width * 0.025,
                  width: width,
                  height: height,
                  child: Container(
                    width: scrWidth,
                    height: scrHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4064FA),
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000),
                      opacity: opc,
                      child: Center(
                          child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.width * 0.15,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/titlewhite.png"),
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
