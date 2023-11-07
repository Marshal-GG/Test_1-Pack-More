import '../../../routes/routes_config.dart';
import 'base_login_setup_repo.dart';

class LoginSetupRepository extends BaseLoginSetupRepository {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
            (uid) => Fluttertoast.showToast(msg: 'Login Successful'),
          );
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
        msg: error.message.toString(),
        gravity: ToastGravity.TOP,
      );
    }
  }
}
