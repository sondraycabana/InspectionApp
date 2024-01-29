import 'package:flutter/material.dart';

class InspectFirstPage extends StatelessWidget {
  const InspectFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 0),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableText(
                    text: "Steps on how to inspect",

                    // fontSize: 17,
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  ),
                  ReusableText(
                    text: "It is important to note all these ",
                    styles: const [
                      TextSpan(
                        text: 'STEPS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      TextSpan(
                        text: ' before',
                        style: TextStyle(
                          fontStyle:
                              FontStyle.italic, // Add any additional styles
                        ),
                      ),
                    ],
                  ),
                  ReusableText(
                    text: "starting your inspection;",
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 0),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Container(
                child: ReusableContainer(
                  circles: [
                    CircleWidget(1),
                    CircleWidget(2),
                    CircleWidget(3),
                    CircleWidget(4),
                    CircleWidget(5),
                    CircleWidget(6),
                    CircleWidget(7),
                    CircleWidget(8),
                  ],
                  description:
                      'Park your Vehicle in a well-lit, shaded, and spacious area, ensuring there are no obstructions.',
                  imagePath: 'assets/images/sample_image.jpg',
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReusableButton(
                    text: 'Skip',
                    onPressed: () {
                      // Add your logic for the button without background
                      print('Button Without Background Pressed');
                    },
                  ),
                  SizedBox(height: 20),
                  ReusableButton(
                    text: 'Next step',
                    onPressed: () {
                      // Add your logic for the button with background
                      print('Button With Background Pressed');
                    },
                    backgroundColor:
                        Colors.blue, // Set your desired background color
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class ReusableContainer extends StatelessWidget {
  final List<Widget> circles;
  final String description;
  final String imagePath;

  const ReusableContainer({
    super.key,
    required this.circles,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlueAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: circles,
          ),
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              description,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Image.asset(
              "assets/images/img1.png",
              width: 400,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class CircleWidget extends StatelessWidget {
  final int number;

  CircleWidget(this.number, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            Colors.white70, // Set a consistent background color for all circles
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}

class ReusableText extends StatelessWidget {
  final String text;
  final List<TextSpan>? styles;
  final EdgeInsetsGeometry padding;

  ReusableText({
    required this.text,
    this.styles,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text.rich(
        TextSpan(
          text: text,
          style: TextStyle(
            fontSize: 17, // Set the desired font size
          ),
          children: styles,
        ),
      ),
    );
  }
}

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  ReusableButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: backgroundColor, // Set the background color
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16, // Set the desired font size
          ),
        ),
      ),
    );
  }
}
