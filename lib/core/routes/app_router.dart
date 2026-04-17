import 'package:ct_notes_app/features/auth/views/login_screen.dart';
import 'package:ct_notes_app/features/auth/views/signup_screen.dart';
import 'package:ct_notes_app/features/notes/views/add_note_screen.dart';
import 'package:ct_notes_app/features/notes/views/notes_view_screen.dart';
import 'package:ct_notes_app/features/splash/view/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addNote = '/add-note';

  static final GoRouter router = GoRouter(
    navigatorKey: Get.key,
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const NotesViewScreen(),
      ),
      GoRoute(
        path: addNote,
        builder: (context, state) => const AddNoteScreen(),
      ),
    ],
  );
}
