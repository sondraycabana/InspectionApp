import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inspection_app/app/inspection_onboarding/inspection_onboarding_controller.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/back_text_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/backview_text_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/dashboard_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/front_text_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/intro_text_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/left_text_widget.dart';
import 'package:inspection_app/app/inspection_onboarding/views/widgets_text_widgets/right_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/back_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/backview_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/dashboard_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/front_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/intro_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/left_text_widget.dart';
// import 'package:inspection_app/app/inspection_onboarding/views/widgets/text_widgets/right_text_widget.dart';
import 'package:inspection_app/app/utils/fade_in_animation.dart';

class InspectionOnboardingView extends StatefulWidget {
  final Widget nextPage;
  const InspectionOnboardingView({super.key, required this.nextPage});

  @override
  State<InspectionOnboardingView> createState() =>
      _InspectionOnboardingViewState();
}

class _InspectionOnboardingViewState extends State<InspectionOnboardingView> {
  final InspectionOnboardingController _controller =
  InspectionOnboardingController();

  int currentStep = 0;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Step on how to inspect',
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 22,
                    color: Color(0xff344054),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .04),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: "It is important to note all these ",
                      style: TextStyle(
                        height: 1.4,
                        fontSize: 16,
                        color: Color(0xff5F738C),
                      ),
                      children: [
                        TextSpan(
                          text: 'STEPS',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7A5AF8),
                          ),
                        ),
                        TextSpan(
                          text: ' before starting our inspection ;',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                    horizontal: 12.0,
                  ),
                  height: MediaQuery.of(context).size.height * .62,
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F3FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (int i = 0; i < 8; i++)
                            stepWidget("${i + 1}".toString(),
                                isCurrentPage: i == currentStep ? true : false),
                        ],
                      ),
                      currentStep == 0
                          ? const IntroTextWidget()
                          : currentStep == 1
                          ? const FrontTextWidget()
                          : currentStep == 2
                          ? const LeftTextWidget()
                          : currentStep == 3
                          ? const BackTextWidget()
                          : currentStep == 4
                          ? const RightTextWidget()
                          : currentStep == 5
                          ? const SizedBox()
                          : currentStep == 6
                          ? const DashboardTextWidget()
                          : const BackViewTextWidget(),
                      FadeInAnimation(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 600),
                        child: Column(
                          children: [
                            currentStep != 0
                                ? Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: Text(
                                currentStep == 1
                                    ? "Front View"
                                    : currentStep == 2
                                    ? "Left View ( Driver side )"
                                    : currentStep == 3
                                    ? "Back View"
                                    : currentStep == 4
                                    ? "Right View"
                                    : currentStep == 5
                                    ? "Chassis number"
                                    : currentStep == 6
                                    ? "Vehicle Dashboard"
                                    : "Vehicle Backview",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff909090),
                                ),
                              ),
                            )
                                : const SizedBox(),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(_controller
                                  .inspectionOnboardingData[currentStep].image),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            currentStep == 7
                ? customButton(
                width: MediaQuery.of(context).size.width,
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.nextPage,
                  ),
                ),
                text: "Start Inspection")
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customButton(
                    width: MediaQuery.of(context).size.width * .42,
                    backgroundColor: Colors.white,
                    textColor: const Color(0xff344054),
                    onPressed: () => setState(() {
                      if (currentStep < 7) {
                        currentStep += 1;
                      }
                    }),
                    text: "Skip"),
                customButton(
                    width: MediaQuery.of(context).size.width * .42,
                    onPressed: () => setState(() {
                      if (currentStep < 7) {
                        currentStep += 1;
                      }
                    }),
                    text: "Next Step"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget stepWidget(String stepIndex, {isCurrentPage}) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 11.0),
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      duration: const Duration(milliseconds: 1000),
      child: RichText(
        text: TextSpan(
          text: isCurrentPage ? "STEP  " : "",
          style: const TextStyle(
            height: 1.5,
            fontSize: 17,
            color: Color(0xff344054),
          ),
          children: [
            TextSpan(
              text: stepIndex,
              style: TextStyle(
                height: 1.5,
                fontSize: 15,
                color: isCurrentPage
                    ? const Color(0xff7A5AF8)
                    : const Color(0xff344054),
                fontWeight: isCurrentPage ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton({
    required void Function()? onPressed,
    required String text,
    Color backgroundColor = const Color(0xff3BAA90),
    Color textColor = Colors.white,
    dynamic width,
  }) {
    return SizedBox(
      height: 50,
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
      ),
    );
  }
}