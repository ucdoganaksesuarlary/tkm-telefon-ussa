import 'package:flutter/material.dart';

void main() {
  runApp(const TkmTelefonUssa());
}

class TkmTelefonUssa extends StatelessWidget {
  const TkmTelefonUssa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM TELEFON USSA',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF06101C),
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF06101C),
        elevation: 0,
        title: const Text(
          'TKM TELEFON USSA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Telefon meseläňiz üçin\nbir ýerde!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Arza bermek bölümi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0066FF),
                    Color(0xFF003B99),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'TELEFON BEJERTMEK',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Arzaňyzy aňsat we çalt iberiň!',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                    ),
                    child: const Text(
                      'Arza ber →',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // Esasy düwmeler
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                _menuButton(
                  Icons.build,
                  'Telefon\nbejertmek',
                  Colors.blue,
                ),
                _menuButton(
                  Icons.receipt_long,
                  'Arzalarym',
                  Colors.blue,
                ),
                _menuButton(
                  Icons.payments,
                  'Bahalar',
                  Colors.blue,
                ),
                _menuButton(
                  Icons.shopping_cart,
                  'Aksessuarlar',
                  Colors.blue,
                ),
                _menuButton(
                  Icons.phone,
                  'Habarlaşmak',
                  Colors.blue,
                ),
                _menuButton(
                  Icons.location_on,
                  'Biziň salgymyz',
                  Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              'Nähili işleýär?',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _step(1, 'Maglumatlary doldur'),
            _step(2, 'Surat / wideo goş'),
            _step(3, 'Arzany iber'),
            _step(4, 'Biz habar bereris'),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF101D2B),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.blueAccent,
                    size: 42,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ynamly we professional hyzmat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Telefonyňyz biziň elimizde howpsuz!',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Aşaky menýu
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0A1725),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Baş sahypa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Arzalarym',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Arza ber',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Bahalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  static Widget _menuButton(
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF101D2B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.blueGrey,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 34,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _step(int number, String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF101D2B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
