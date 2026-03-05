import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Widget> _pages = const [
    HomePage(),
    Center(child: Text("Checklist Page")),
    Center(child: Text("Dashboard Page")),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Icon _buildAnimatedIcon(IconData icon, int index) {
    return Icon(
      icon,
      size: _currentIndex == index
          ? 30 + (_animation.value * 8)
          : 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Travel Checklist"),
        backgroundColor: const Color.fromARGB(192, 146, 118, 198),
        centerTitle: true,
      ),

      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: const Center(
          child: Text("Menu Items Here"),
        ),
      ),

      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(192, 146, 118, 198),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.home, 0),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.checklist, 1),
            label: "Checklist",
          ),
          BottomNavigationBarItem(
            icon: _buildAnimatedIcon(Icons.dashboard, 2),
            label: "Dashboard",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.flight, size: 80, color: Colors.white),
          SizedBox(height: 20),
          Text(
            "Welcome to Travel Checklist",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Text(
            "Plan your trip smartly",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
