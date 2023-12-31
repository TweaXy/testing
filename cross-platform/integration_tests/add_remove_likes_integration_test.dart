import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Add/Remove Likes Tests', () {
    testWidgets('Add/Remove Like test', (WidgetTester tester) async {
      // Sign in
      app.main();
      await tester.pumpAndSettle();

      var logInButton =
            find.byKey(const ValueKey(SignInKeys.welcomePageLogInButton));
      await tester.tap(logInButton);
      await tester.pumpAndSettle();

      var emailTextField = find.byKey(const ValueKey(SignInKeys.emailFieldKey));
      await tester.enterText(emailTextField, users[0][0]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      var nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      var passwordTextField =
          find.byKey(const ValueKey(SignInKeys.passwordFieldKey));
      await tester.enterText(passwordTextField, users[0][1]);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      nextButton = find.byKey(const ValueKey(SignInKeys.nextButtonKey));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.ensureVisible(nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      
      final tweetContainer =
          find.byKey(const ValueKey(HomePageKeys.tweetContainer)).first;
      expect(tweetContainer, findsOneWidget);

      final tweetLikesCount = find.descendant(
        of: tweetContainer,
        matching: find.byKey(const ValueKey(HomePageKeys.tweetLikesCount)),
      );

      // Adding a like
      var text = tweetLikesCount.toString();
      var likes = int.parse(text);
      await tester.tap(tweetLikesCount);
      await tester.pump();
      var newText = tweetLikesCount.toString();
      var newLikes = int.parse(newText);
      expect(newLikes > likes, true);

      // Removing a like
      text = tweetLikesCount.toString();
      likes = int.parse(text);
      await tester.tap(tweetLikesCount);
      await tester.pump();
      newText = tweetLikesCount.toString();
      newLikes = int.parse(newText);
      expect(newLikes < likes, true);
    });
  });
}
