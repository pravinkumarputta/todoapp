import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todoapp/pages/home_page/home_page.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  static route() => 'IntroPage';

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  preparePageViewModels() {
    return [
      PageViewModel(
        title: "Create todos",
        body: "Have note your daily todos with this app better.",
        image: Center(
          child: Image.asset("assets/images/img_1.png", height: 275.0),
        ),
      ),
      PageViewModel(
        title: "Mark up completed",
        body: "You can mark your completed todos and leave for the day.",
        image: Center(
          child: Image.asset("assets/images/img_2.png", height: 275.0),
        ),
      ),
      PageViewModel(
        title: "Delete old todos",
        body: "Remove all unnecessary and done todos from the list.",
        image: Center(
          child: Image.asset("assets/images/img_3.png", height: 275.0),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("IntroPage")),
      body: IntroductionScreen(
        pages: preparePageViewModels(),
        onDone: () {
          Navigator.of(context).pushReplacementNamed(HomePage.route());
        },
        onSkip: () {
          Navigator.of(context).pushReplacementNamed(HomePage.route());
        },
        showSkipButton: true,
        skip: const Text('SKIP'),
        next: const Icon(Icons.arrow_forward),
        done: const Text("DONE", style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
