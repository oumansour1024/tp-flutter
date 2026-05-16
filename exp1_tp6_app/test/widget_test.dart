import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exp1_tp6_app/main.dart';

void main() {
  testWidgets('App displays login page on startup', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the login page is displayed when no user is logged in.
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Se Connecter'), findsOneWidget);
    expect(find.text('Créer un compte'), findsOneWidget);
  });
}