import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const DiceRollerApp());
}

class DiceRollerApp extends StatelessWidget {
  const DiceRollerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

/* ---------------- HOME ---------------- */

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🎲 Dice Roller')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const RegularDiceScreen()),
              ),
              child: const Text('Regular Dice'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const KingOfTokyoScreen()),
              ),
              child: const Text('King of Tokyo Mode'),
            ),
          ],
        ),
      ),
    );
  }
}

/* ---------------- REGULAR DICE ---------------- */

class RegularDiceScreen extends StatefulWidget {
  const RegularDiceScreen({super.key});

  @override
  State<RegularDiceScreen> createState() => _RegularDiceScreenState();
}

class _RegularDiceScreenState extends State<RegularDiceScreen> {
  final Random _rng = Random();
  List<int> dice = [1];

  void rollDice() {
    setState(() {
      dice = dice.map((_) => _rng.nextInt(6) + 1).toList();
    });
  }

  void addDice() {
    setState(() {
      dice.add(_rng.nextInt(6) + 1);
    });
  }

  void resetDice() {
    setState(() {
      dice = [_rng.nextInt(6) + 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regular Dice')),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: dice
                  .map((d) => Image.asset('assets/dice/dice_$d.png'))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: rollDice, child: const Text('Roll')),
              ElevatedButton(onPressed: addDice, child: const Text('Add Dice')),
              ElevatedButton(onPressed: resetDice, child: const Text('Reset')),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

/* ---------------- KING OF TOKYO ---------------- */

class KingOfTokyoScreen extends StatefulWidget {
  const KingOfTokyoScreen({super.key});

  @override
  State<KingOfTokyoScreen> createState() => _KingOfTokyoScreenState();
}

class _KingOfTokyoScreenState extends State<KingOfTokyoScreen> {
  final Random _rng = Random();

  List<int> activeDice = [];
  List<int> storedDice = [];
  int rollsLeft = 3;

  @override
  void initState() {
    super.initState();
    _startNewTurn();
  }

  void _startNewTurn() {
    activeDice = List.generate(6, (_) => _rng.nextInt(6) + 1);
    storedDice.clear();
    rollsLeft = 3;
  }

  void rollDice() {
    if (rollsLeft == 0) return;

    setState(() {
      for (int i = 0; i < activeDice.length; i++) {
        activeDice[i] = _rng.nextInt(6) + 1;
      }
      rollsLeft--;
    });
  }

  void storeDie(int index) {
    setState(() {
      storedDice.add(activeDice[index]);
      activeDice.removeAt(index);
    });
  }

  void unstoreDie(int index) {
    setState(() {
      activeDice.add(storedDice[index]);
      storedDice.removeAt(index);
    });
  }

  void endTurn() {
    setState(() {
      _startNewTurn();
    });
  }

  Widget diceGrid(List<int> dice, Function(int) onTap) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(dice.length, (i) {
        return GestureDetector(
          onTap: () => onTap(i),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              'assets/dice/king_of_tokyo_${dice[i]}.png',
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('King of Tokyo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'Rolls Left: $rollsLeft',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),

            const Text('Active Dice', style: TextStyle(fontSize: 18)),
            diceGrid(activeDice, storeDie),

            const SizedBox(height: 20),
            const Text('Stored Dice', style: TextStyle(fontSize: 18)),
            diceGrid(storedDice, unstoreDie),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: rollDice,
                  child: const Text('Reroll'),
                ),
                ElevatedButton(
                  onPressed: endTurn,
                  child: const Text('End Turn'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
