import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    AppRouter.router.go(AppRouter.login);
  }
}
