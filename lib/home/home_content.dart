import 'package:flutter/material.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>{

  int _currentIndex = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Natação Unaerp', style: TextStyle(color: Colors.white)),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomTreinador(_currentIndex, _onTabTapped),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3'),
    );
  }
}

class BottomAtleta extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomAtleta(this.currentIndex, this.onTabTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Meus Treinos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

class BottomTreinador extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomTreinador(this.currentIndex, this.onTabTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Atletas',
        ),
        BottomNavigationBarItem(
          icon: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Icon(Icons.add_circle_outline, size: 40),
            ),
          ),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

class BottomAdmin extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;

  const BottomAdmin(this.currentIndex, this.onTabTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports),
          label: 'Meus Treinos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Historico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}


