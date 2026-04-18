import 'package:flutter/material.dart';


void main(){
  runApp(
      const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState()=> _HomePageState();

}

class _HomePageState extends State<HomePage> {
  int compteur = 0;
  String colorbg = "0xFF6200EE";

  void changerCouleur(){
    setState(() {
          if(compteur > 0){
            // GREEN
          colorbg = "0xFF4CAF50";
        } else if(compteur < 0){
          // ROUGE
          colorbg = "0xFFF44336";
        }else {
          colorbg = "0xFF6200EE";
        }
    });

  }

  

  void restarter(){
    setState(() {
      compteur = 0;
    });
  }

  void incrementer(){
    setState(() {
      compteur++;
    });
  }

  void decrementer(){
    setState(() {
      compteur--;
    });
  }

  String message(){
    if(compteur > 0){
      return "Positif";
    } else if(compteur < 0){
      return "Négatif";
    } else {
      return "Zéro";
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title:const Text("Accueil"),
        backgroundColor:Color(int.parse(colorbg)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Compteur : $compteur",
              style: TextStyle(
                fontSize: 24,
                color: Color(int.parse(colorbg)),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              message(),
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:(){incrementer(); changerCouleur();},
                  child: const Icon(Icons.add ,color: Color(0xFF4CAF50),),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: (){decrementer(); changerCouleur();},
                  child: const Icon(Icons.remove ,color: Color(0xFFF44336),),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: (){restarter(); changerCouleur();},
                  child: const Icon(Icons.refresh ,color: Color(0xFF6200EE),),
                ),  
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              child: const Text("Aller à la page 2"),
            ),
          ],
        ),
      ),
    );
  }
}



class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 2"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue sur la page 2 🎉",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text("Retour"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ThirdPage()),
                );
              },
              child: const Text("Aller à la page 3"),
            ),
          ],
        ),
      ),
    );
  }
}


class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 3"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bienvenue sur la page 3 🎉",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text("Retour"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text("Aller à la page d'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}