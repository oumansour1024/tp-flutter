import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth state stream pour écouter les changements de connexion
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Connexion avec email et mot de passe
  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'Aucun utilisateur trouvé avec cet email.';
          break;
        case 'wrong-password':
          message = 'Mot de passe incorrect.';
          break;
        case 'invalid-credential':
          message = 'Email ou mot de passe invalide.';
          break;
        default:
          message = 'Erreur de connexion : ${e.message}';
      }
      throw Exception(message);
    }
  }

  // Création de compte avec email et mot de passe
  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Code: ${e.code}');
      print('Firebase Auth Message: ${e.message}');
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Cet email est déjà utilisé.';
          break;
        case 'weak-password':
          message = 'Le mot de passe est trop faible (minimum 6 caractères).';
          break;
        case 'invalid-email':
          message = 'Format d\'email invalide.';
          break;
        default:
          message = 'Erreur d\'inscription : ${e.message}';
      }
      throw Exception(message);
    }
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Obtenir l'utilisateur actuel
  User? get currentUser => _auth.currentUser;
}