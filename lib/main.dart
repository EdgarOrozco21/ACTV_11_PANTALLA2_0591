import 'package:flutter/material.dart';

void main() {
  runApp(const FinanTrackApp());
}

class FinanTrackApp extends StatelessWidget {
  const FinanTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinanTrack',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        primaryColor: const Color(0xFF00695C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00695C),
          primary: const Color(0xFF00695C),
          secondary: const Color(0xFF00897B),
          surface: Colors.white,
          background: const Color(0xFFF4F6F8),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF00695C),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF00695C),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF00695C),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
        ),
      ),
      home: const IngresosScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// DATA MODEL
// ---------------------------------------------------------------------------

class Income {
  final String id;
  final String source;
  final double amount;
  final DateTime date;

  Income({
    required this.id,
    required this.source,
    required this.amount,
    required this.date,
  });
}

// ---------------------------------------------------------------------------
// MOCK DATA
// ---------------------------------------------------------------------------

// TODO: Replace mock list with FirebaseFirestore.instance.collection('incomes')
final List<Income> mockIncomes = [
  Income(id: '1', source: 'Salario', amount: 2500.00, date: DateTime(2026, 2, 15)),
  Income(id: '2', source: 'Salario', amount: 2500.00, date: DateTime(2026, 1, 30)),
  Income(id: '3', source: 'Freelance', amount: 1200.50, date: DateTime(2026, 1, 20)),
  Income(id: '4', source: 'Salario', amount: 2500.00, date: DateTime(2026, 1, 15)),
  Income(id: '5', source: 'Venta Online', amount: 450.00, date: DateTime(2026, 1, 10)),
];

// ---------------------------------------------------------------------------
// SCREEN UI
// ---------------------------------------------------------------------------

class IngresosScreen extends StatelessWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis ingresos"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          itemCount: mockIncomes.length,
          itemBuilder: (context, index) {
            final income = mockIncomes[index];
            return IncomeCard(income: income);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Index 2 is "Ingresos"
        onTap: (index) {
          // Navigation logic would go here
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Gastos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Ingresos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class IncomeCard extends StatelessWidget {
  final Income income;

  const IncomeCard({super.key, required this.income});

  // Helper for date formatting
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  // Helper for currency formatting
  String _formatCurrency(double amount) {
    return "\$${amount.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // COLUMNA IZQUIERDA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF263238),
                      ),
                      children: [
                        const TextSpan(
                          text: "Fuente: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: income.source,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF607D8B),
                      ),
                      children: [
                        const TextSpan(
                          text: "Fecha: ",
                        ),
                        TextSpan(
                          text: _formatDate(income.date),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // COLUMNA DERECHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatCurrency(income.amount),
                  style: const TextStyle(
                    color: Color(0xFF00897B),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ActionButton(
                      icon: Icons.edit_outlined,
                      color: const Color(0xFF00897B),
                      onTap: () {
                        // TODO: Implement Edit Logic
                      },
                    ),
                    const SizedBox(width: 12),
                    _ActionButton(
                      icon: Icons.delete_outline,
                      color: const Color(0xFFE57373), // Rojo suave para eliminar
                      onTap: () {
                        // TODO: Implement Delete Logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF00897B).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
    );
  }
}