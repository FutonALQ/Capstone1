import 'package:capstone_1/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage("lib/assets/daniel-jensen-tQpypKA92k8-unsplash.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100.0, left: 20.0),
                child: Text(
                  "Start your next \nadventure, where \nnew friends meet",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: Color.fromARGB(255, 50, 50, 50)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 530.0),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      print(MediaQuery.of(context).size.height);
                      print(MediaQuery.of(context).size.width);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                          (route) => false);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "Let's Start !",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
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
    );
  }
}
