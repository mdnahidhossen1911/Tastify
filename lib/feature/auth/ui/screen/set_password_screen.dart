import 'package:flutter/material.dart';
import 'package:tastify/feature/auth/ui/screen/sign_up.dart';
import 'package:tastify/feature/auth/ui/widgets/screen_background.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  static String name = 'setPasswordScreen';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set password",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
              ),
              Text(
                "Minimum length password 8 character with Latter and number combination.",
              ),
              SizedBox(height: 12),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 3),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "*****************",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),SizedBox(height: 12),
              Text(
                "Confirm Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 3),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "*****************",
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 16,),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(253, 96, 17, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),

              Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Colors.black),),
                    TextButton(
                      onPressed: (){
                        Navigator.pushNamed(context, SignUpScreen.name);
                      },
                      child: Text("Login",
                          style: TextStyle(color: Color.fromRGBO(253, 96, 17, 1)),
                        ),
                    )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
