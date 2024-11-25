import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger_app/app/extinsion.dart';
import 'package:task_manger_app/login/cubit/login_cubit.dart';
import 'package:user_repository/user_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(userRepository: context.read<UserRepository>()),
      child: const LoginContent(),
    );
  }
}


class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> with RestorationMixin {
  final emailController = RestorableTextEditingController();
  final passwordController = RestorableTextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  String? get restorationId => 'login_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(emailController, 'email');
    registerForRestoration(passwordController, 'password');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state.isFailure){
          context.showSnackBar(
              text: 'Something Went Wrong !',
              backgroundColor: Colors.red,);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: LoginForm (
                  formKey: formKey,
                  emailController: emailController,
                  passwordController: passwordController,),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController, super.key,
  });

  final GlobalKey<FormState> formKey;
  final RestorableTextEditingController emailController;
  final RestorableTextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final isSigningIn = context.select<LoginCubit, bool>(
          (cubit) => cubit.state.isSigningIn,
    );
    const  loader= Center(child: CircularProgressIndicator(),);
    return isSigningIn ? loader :Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign In.',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: emailController.value,
            decoration: const InputDecoration(
              hintText: 'Email',
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: passwordController.value,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isSigningIn ?
            null : () {
              const form = SignInForm(username: 'emilys'
                , password: 'emilyspass',);
              context.read<LoginCubit>().
              signInWithEmailAndPassword(form);
            },
            child: const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
