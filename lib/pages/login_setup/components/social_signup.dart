import '../../../core/routes/routes_config.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        const OrDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkResponse(
              onTap: () async {
                await FirebaseService().signInWithGoogle();
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home-page',
                    (route) => false,
                  );
                });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: colorScheme.primary,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/icons/google.png",
                  color: colorScheme.onBackground,
                  height: 20,
                  width: 20,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          buildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }
}

Expanded buildDivider() {
  return const Expanded(
    child: Divider(
      color: Color(0xFFD9D9D9),
      height: 1.5,
    ),
  );
}
