import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/routes_config.dart';
import '../components/have_account_check.dart';
import '../components/social_signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String kEmailNullError = "Please Enter your email";
  String kInvalidEmailError = "Please Enter Valid Email";
  String kPassNullError = "Please Enter your password";
  String kShortPassError = "Password is too short";

  String kMatchPassError = "Passwords don't match";
  String kNameNullError = "Please Enter your name";
  String kPhoneNumberNullError = "Please Enter your phone number";
  String kAddressNullError = "Please Enter your address";
  String kDOBNullError = "Please Enter your DOB";

  String? email, password;
  final List<String?> errors = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginSetupBloc, LoginSetupState>(
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        return buildBody(colorScheme, state, context);
      },
    );
  }

  Scaffold buildBody(
      ColorScheme colorScheme, LoginSetupState state, BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(24.sp),
                SvgPicture.asset(
                  'assets/icons/login.svg',
                  height: 600.h,
                  width: 600.w,
                ),
                Gap(24.sp),
                buildEmailFormField(colorScheme),
                Gap(24.sp),
                buildPasswordFormField(colorScheme),
                Gap(24.sp),
                buildLoginButton(state),
                Gap(24.sp),
                buildForgotPassword(colorScheme),
                Gap(16.sp),
                AlreadyHaveAnAccountCheck(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signup-page');
                  },
                ),
                SocialSignUp()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: const Text("Login"),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  TextFormField buildEmailFormField(ColorScheme colorScheme) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: _emailController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        setState(() {
          email = value.trim();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return kInvalidEmailError;
        }
        return null;
      },
      onSaved: (newValue) {
        _emailController.text = newValue!;
      },
      decoration: InputDecoration(
        labelText: "Email Address",
        prefixIcon: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Icon(
            Icons.person,
            color: colorScheme.primary,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField buildPasswordFormField(ColorScheme colorScheme) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: _passwordController,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        setState(() {
          password = value.trim();
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return kPassNullError;
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return kShortPassError;
        }
        return null;
      },
      onSaved: (value) {
        _passwordController.text = value!;
      },
      obscureText: true,
      cursorColor: colorScheme.primary,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Icon(
            Icons.lock,
            color: colorScheme.primary,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        alignLabelWithHint: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  FilledButton buildLoginButton(LoginSetupState state) {
    bool isButtonDisabled =
        _emailController.text.isEmpty || _passwordController.text.isEmpty;

    return FilledButton(
      onPressed: isButtonDisabled
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                BlocProvider.of<LoginSetupBloc>(context).add(
                  LoginSubmitEvent(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ),
                );
                if ((state is LoginPageSubmitState &&
                    !state.isLoading &&
                    !state.isError)) {
                  Navigator.pushReplacementNamed(context, '/home-page');
                }
              }
            },
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text("Login".toUpperCase()),
    );
  }

  InkResponse buildForgotPassword(ColorScheme colorScheme) {
    return InkResponse(
      onTap: () {
        Navigator.pushNamed(context, '/forgot-password-page');
      },
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          color: colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }
}
