import 'package:flutter/material.dart';
import 'package:recipe_book/ui/screens/all_recipes_screen.dart';
import 'package:recipe_book/ui/screens/main_recipe_screen.dart';
import 'package:recipe_book/ui/screens/shopping_list_screen.dart';
import 'package:recipe_book/ui/screens/show_recipe_screen.dart';
import 'package:recipe_book/ui/screens/signup_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  //   Widget build(BuildContext context) {
  //     return MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: LoginPage(),
  //     );
  //   }
  // }
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<LoginPage> {
  var username = TextEditingController();
  var email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidden = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Curved Container
              Container(
                height: 350,
                decoration: const BoxDecoration(
                  color: Color(0xFF002D40), // Dark blue background color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(108),
                    bottomRight: Radius.circular(108),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 250),
                      Image.asset("images/login-logo.png", height: 100),

                      // Text(
                      //   "LOGO HERE",
                      //   style: TextStyle(color: Colors.white, fontSize: 20),
                      // ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Login Text
              const Padding(
                padding: EdgeInsets.only(right: 170),
                child: Text(
                  "HEY!\nLOGIN NOW",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(27, 56, 74, 1),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              // Email TextField
              Container(
                width: 355,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 238, 242, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "invalid username";
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    // prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // hintText: "Enter your name ",
                    // hintStyle: TextStyle(fontSize: 20, color: Colors.black)
                    // border: InputBorder.none,
                    // contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Password TextField
              Container(
                width: 355,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 238, 242, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "invalid password";
                    }
                    return null;
                  },
                  controller: email,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: hidden,
                  decoration: InputDecoration(
                    labelText: " Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // prefixIcon: Icon(Icons.lock),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          hidden = !hidden;
                          print(hidden);
                        });
                      },
                    ),
                  ),

                  // keyboardType: TextInputType.visiblePassword,
                  // obscureText: hidden,
                  // decoration: InputDecoration(
                  //     // prefix: Icon(Icons.password),
                  //     labelText: 'Password',
                  //     // prefixIcon: Icon(Icons.password),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     suffixIcon: Icon(Icons.visibility_off)
                  //     // hintText: "Enter your name ",
                  //     // hintStyle: TextStyle(fontSize: 20, color: Colors.black)
                  //     // border: InputBorder.none,
                  //     // contentPadding: EdgeInsets.all(12),
                  //     ),
                ),
              ),

              const SizedBox(height: 15),

              // Login Button
              SizedBox(
                width: 205,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    final bool result = formKey.currentState!.validate();
                    if (result) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainRecipeScreen(
                              // username: username.text,
                              // email: email.text,
                            );
                          },
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(252, 156, 13, 1),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 18)),
                ),
              ),

              // const SizedBox(height: 2),

              // Forgot Password
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              // const SizedBox(height: 2),

              // Social Login
              const Text("Or login with-"),
              // const SizedBox(height: 2),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Add Google signup logic
                      },
                      icon: Image.asset(
                        'images/google-logo.png', // Replace with Google logo path
                        height: 30,
                      ),
                    ),
                    // const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {
                        // Add Apple signup logic
                      },
                      icon: Image.asset(
                        'images/Facebook-logo.png', // Replace with Apple logo path
                        height: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Add Apple signup logic
                      },
                      icon: Image.asset(
                        'images/apple-logo.png',
                        // Replace with Apple logo path
                        height: 35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              // Register Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CreateAccountPage();
                          },
                        ),
                      );
                      // Navigate to login page
                    },
                    child: const Text(
                      'Create new',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
