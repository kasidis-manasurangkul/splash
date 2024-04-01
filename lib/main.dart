import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  late BorderRadius borderRadius = BorderRadius.circular(0);
  double opc = 1.0;
  double topPos = 0.0;

  @override
  void initState() {
    super.initState();

    // Initial size is set to full screen in didChangeDependencies
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2)).then((value) {
        setState(() {
          width = MediaQuery.of(context).size.width * 0.14;
          height = MediaQuery.of(context).size.width * 0.14;
          borderRadius = BorderRadius.circular(50);
        });
      });
      Future.delayed(const Duration(seconds: 3)).then((value) {
        setState(() {
          opc = 0.0;
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
        home: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.15,
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/titleblack.png"),
                ),
              )),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  SizedBox(
                    width: scrWidth,
                    height: scrHeight,
                    // color: Color(0xFF4064FA),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(seconds: 2),
                          left: (scrWidth / 2 - width / 2) +
                              MediaQuery.of(context).size.width * 0.03,
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
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
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
                ],
              ),
            ),
          ],
        ));
  }
}
