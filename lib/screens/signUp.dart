import 'package:flutter/material.dart';
import 'package:sign_up_page/services/firebase_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController nameController;

  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Sign up using email and password'),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: emailController,
                  onChanged: (value) {
                    emailController.text = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'example@gmail.com',
                    labelText: 'Enter your mail',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: passwordController,
                  onChanged: (value) {
                    passwordController.text = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: '********',
                    labelText: 'Enter your password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  onChanged: (value) {
                    nameController.text = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Kamran Hashmi',
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (!isValidForm(context)) {
                          setState(() {
                            isLoading = false;
                          });
                          return;
                        }

                        final isSaved = await FirebaseHelper.saveUser(
                          context: context,
                          email: emailController.text,
                          passWord: passwordController.text,
                          name: nameController.text,
                        );

                        print(isSaved);

                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: Text('Sign Up'),
                    )
            ],
          ),
        ),
      ),
    );
  }

  bool isValidForm(BuildContext context) {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fill all fields'),
        ),
      );
      return false;
    }

    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must be at least 8 character length'),
        ),
      );
      return false;
    }

    return true;
  }
}
