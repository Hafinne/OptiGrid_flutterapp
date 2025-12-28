import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const OptiGridApp());
}

class OptiGridApp extends StatelessWidget {
  const OptiGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OptiGrid: VPP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF050505), // Ultra Dark
        primaryColor: const Color(0xFF00FF7F), // Neon Spring Green
        cardColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF7F),
          secondary: Color(0xFF00E5FF), // Cyan Neon
          surface: Color(0xFF1E1E1E),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Sayfalar
  final List<Widget> _pages = [
    const HomeScreen(),
    const GridScreen(),
    const InvestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: const Color(0xFF050505),
          selectedItemColor: const Color(0xFF00FF7F),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Digital Twin",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.hub), label: "VPP Grid"),
            BottomNavigationBarItem(
              icon: Icon(Icons.candlestick_chart),
              label: "Invest",
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 1. HOME SCREEN: ENGINEERING & LINEAR ALGEBRA SHOW
// ---------------------------------------------------------
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _temp = 24.0;
  final double _outsideTemp = -2.0;
  final double _insulationFactor = 1.8; // U-Value

  // Matematiksel Hesaplama (Linear Algebra Logic)
  // Cost = (Tin - Tout) * U * Price
  double get _calculateCost => (_temp - _outsideTemp) * _insulationFactor * 2.5;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("DIGITAL TWIN", "Real-time Thermodynamics"),
            const SizedBox(height: 20),

            // Dış Sıcaklık Kartı
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Outdoor Temp",
                    "${_outsideTemp}°C",
                    Icons.ac_unit,
                    Colors.cyan,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildStatCard(
                    "Insulation (U)",
                    "1.8 W/m²K",
                    Icons.layers,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Termostat Dairesi
            Center(
              child: SizedBox(
                height: 250,
                width: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Arka Plan Glow Efekti
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00FF7F).withOpacity(0.2),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    // Progress Indicator
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: CircularProgressIndicator(
                        value: (_temp - 18) / 12, // 18-30 arası normalize et
                        strokeWidth: 15,
                        backgroundColor: Colors.grey[900],
                        valueColor: const AlwaysStoppedAnimation(
                          Color(0xFF00FF7F),
                        ),
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                    // Derece Yazısı
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_temp.toStringAsFixed(1)}°C",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "TARGET",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Slider
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF00FF7F),
                inactiveTrackColor: Colors.grey[800],
                thumbColor: const Color(0xFF00FF7F),
                overlayColor: const Color(0xFF00FF7F).withOpacity(0.2),
                trackHeight: 6,
              ),
              child: Slider(
                value: _temp,
                min: 18,
                max: 30,
                divisions: 24, // 0.5 derece hassasiyet
                label: "${_temp}°C",
                onChanged: (val) => setState(() => _temp = val),
              ),
            ),

            const Spacer(),

            // Sonuç Paneli (Hesaplama)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ESTIMATED COST",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        "Per Hour",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "${_calculateCost.toStringAsFixed(2)} TL",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00FF7F), // Para Rengi
                      fontFamily: 'Courier', // Mühendislik Havası
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. GRID SCREEN: LOGIC DESIGN & VPP SHOW (HİLELİ)
// ---------------------------------------------------------
class GridScreen extends StatefulWidget {
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  bool _isGridCritical = false;
  int _userPoints = 1250;

  void _triggerSimulation() {
    setState(() {
      _isGridCritical = true;
      _userPoints += 500;
    });

    // Otomatik düzeltme simülasyonu (3 saniye sonra)
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF00FF7F),
            content: Text("GRID STABILIZED via OptiGrid VPP!"),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeader("VPP COMMAND", "Virtual Power Plant Node"),
                    // HİLELİ BUTON (SAĞ ÜST - GİZLİ GİBİ)
                    IconButton(
                      onPressed: _triggerSimulation,
                      icon: const Icon(
                        Icons.warning_amber,
                        color: Colors.white10,
                      ), // Çok silik ikon
                      tooltip: "Simulate Grid Failure",
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Büyük Durum Göstergesi
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isGridCritical
                          ? Colors.red.withOpacity(0.1)
                          : const Color(0xFF00FF7F).withOpacity(0.1),
                      border: Border.all(
                        color: _isGridCritical
                            ? Colors.red
                            : const Color(0xFF00FF7F),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _isGridCritical
                              ? Colors.red.withOpacity(0.4)
                              : const Color(0xFF00FF7F).withOpacity(0.2),
                          blurRadius: 50,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isGridCritical ? Icons.error_outline : Icons.shield,
                          size: 60,
                          color: _isGridCritical
                              ? Colors.red
                              : const Color(0xFF00FF7F),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _isGridCritical ? "CRITICAL" : "NORMAL",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _isGridCritical
                                ? Colors.red
                                : const Color(0xFF00FF7F),
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Logic Gate Logları (Mühendislik Havası için)
                if (_isGridCritical) ...[
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.redAccent),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "⚠️ ALERT RECEIVED: GRID_LOAD > 95%",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "⚙️ EXECUTING LOGIC: IF (GRID==CRITICAL) THEN (REDUCE_TEMP)",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Courier",
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "✅ ACTION: Thermostat lowered by 1°C",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "💰 REWARD: +500 Eco-Credits transferred.",
                          style: TextStyle(
                            color: Color(0xFF00FF7F),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const Text(
                    "Waiting for Grid Signals...",
                    style: TextStyle(
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. INVEST SCREEN: FINANCIAL VISION
// ---------------------------------------------------------
class InvestScreen extends StatefulWidget {
  const InvestScreen({super.key});

  @override
  State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> {
  int _balance = 1750;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader("ECO-INVEST", "Decentralized Energy Fund"),
            const SizedBox(height: 20),

            // Cüzdan Kartı
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00B09B), Color(0xFF96C93D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Asset Value",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$_balance Eco-Credits",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "+12% This Month",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Open Projects",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 15),

            // Yatırım Listesi
            Expanded(
              child: ListView(
                children: [
                  _buildInvestCard("Baku Wind Farm Alpha", "ROI: 14%", 75),
                  _buildInvestCard("Kayseri Solar Collective", "ROI: 8%", 45),
                  _buildInvestCard("Tashkent Hydro Plant", "ROI: 11%", 90),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestCard(String title, String roi, int progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.bolt, color: Color(0xFF00FF7F)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  roi,
                  style: const TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF00FF7F)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              setState(() => _balance -= 100);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Investment Successful!")),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00FF7F),
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// ORTAK WIDGET'LAR
// ---------------------------------------------------------
Widget _buildHeader(String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontFamily: 'Courier',
        ),
      ),
      Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
    ],
  );
}

Widget _buildStatCard(String title, String value, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 10),
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
