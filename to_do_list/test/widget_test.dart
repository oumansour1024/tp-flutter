import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/main.dart'; // Assurez-vous que le nom du package est correct

void main() {
  testWidgets('Test d\'ajout de tâche dans la To-Do List', (WidgetTester tester) async {
    // 1. Charger l'application
    await tester.pumpWidget(const MyApp());

    // 2. Vérifier que le message "Aucune tâche" est présent au début
    expect(find.textContaining('Aucune tâche'), findsOneWidget);

    // 3. Appuyer sur le bouton '+' pour ouvrir la page d'ajout
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Attendre la fin de l'animation de transition

    // 4. Saisir un titre et une description
    await tester.enterText(find.widgetWithText(TextField, 'Titre'), 'Acheter du lait');
    await tester.enterText(find.widgetWithText(TextField, 'Description'), 'Au supermarché');

    // 5. Cliquer sur le bouton 'Enregistrer la tâche'
    await tester.tap(find.text('Enregistrer la tâche'));
    await tester.pumpAndSettle(); // Revenir à l'écran principal

    // 6. Vérifier que la tâche apparaît maintenant dans la liste
    expect(find.text('Acheter du lait'), findsOneWidget);
    expect(find.textContaining('Au supermarché'), findsOneWidget);
  });
}
