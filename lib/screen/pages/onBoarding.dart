import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/screen/navigation/homePage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/images/one.png',
      fit: BoxFit.cover,
      height: double.infinity / 2,
      width: double.infinity / 2,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset('assets/$assetName', width: width);
    // return Text("");
  }

  @override
  Widget build(BuildContext context) {
    var titlestyle = TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor);

    const bodyDecoration = TextStyle(fontSize: 15);

    const bodyStyle = TextStyle(
      fontSize: 19.0,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 300000,
      infiniteAutoScroll: true,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Text("")),
        ),
      ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          // title: "Fractional shares",
          titleWidget: Text(
            "Welcome to Mgahawa App",
            style: titlestyle,
          ),
          bodyWidget: Center(
            child: Text(
                "Instead of having to buy an entire share, invest any amount you want.",
                style: bodyDecoration),
          ),

          image: _buildImage('images/one.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            "This is second Page",
            style: titlestyle,
          ),
          bodyWidget: Center(
            child: Text(
                "Instead of having to buy an entire share, invest any amount you want.",
                style: bodyDecoration),
          ),
          image: _buildImage('images/two.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          titleWidget: Text(
            "tThis is third page",
            style: titlestyle,
          ),
          bodyWidget: Center(
            child: Text(
                "Instead of having to buy an entire share, invest any amount you want.",
                style: bodyDecoration),
          ),
          image: _buildImage('images/three.png'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "Deliverry Page Here",
            style: titlestyle,
          ),
          bodyWidget: Center(
            child: Text(
                "Instead of having to buy an entire share, invest any amount you want.",
                style: bodyDecoration),
          ),
          image: _buildImage('images/three.png'),
          footer: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(0);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                '<- Go Back',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "Get in Time",
            style: titlestyle,
          ),
          bodyWidget: Container(
            child: Text(
              "Save time by making orders..",
              style: bodyStyle,
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('images/four.png'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text(
        'Skip',
        style: TextStyle(fontWeight: FontWeight.w600),
        selectionColor: AppColors.backgroundColor,
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
