import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

const bg = Color(0xFF050B14);
const card = Color(0xFF0B192A);
const blue = Color(0xFF129BFF);
const cyan = Color(0xFF63D1FF);
const white = Color(0xFFF4F8FF);
const sub = Color(0xFF9AAEC3);
const green = Color(0xFF19D67A);

void main() => runApp(const TkmApp());

class TkmApp extends StatelessWidget {
  const TkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM TELEFON USSA',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final pages = const [
    HomePage(),
    RequestsPage(),
    RepairPage(),
    PricesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: BottomNav(
        current: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const names = [
      'Baş sahypa',
      'Arzalar',
      'Arza',
      'Bahalar',
      'Profil'
    ];

    const icons = [
      Icons.home_rounded,
      Icons.assignment_rounded,
      Icons.add_rounded,
      Icons.payments_rounded,
      Icons.person_rounded,
    ];

    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: Color(0xFF09121E),
        border: Border(
          top: BorderSide(color: Color(0xFF17314C)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(5, (i) {
            final selected = current == i;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (i == 2)
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF0879FF),
                              Color(0xFF54D2FF),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: blue.withOpacity(.45),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          size: 27,
                        ),
                      )
                    else
                      Icon(
                        icons[i],
                        size: 24,
                        color: selected ? cyan : Colors.white70,
                      ),
                    const SizedBox(height: 3),
                    Text(
                      names[i],
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: selected
                            ? FontWeight.w800
                            : FontWeight.w500,
                        color: selected ? cyan : Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0C365B),
                  Color(0xFF071321),
                ],
              ),
              border: Border.all(
                color: cyan,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: blue.withOpacity(.35),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.phone_iphone_rounded,
                  size: 39,
                  color: white,
                ),
                Transform.translate(
                  offset: const Offset(7, 8),
                  child: Transform.rotate(
                    angle: -.55,
                    child: const Icon(
                      Icons.build_rounded,
                      size: 23,
                      color: cyan,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TKM',
                  style: TextStyle(
                    fontSize: 30,
                    height: .85,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  'TELEFON USSA',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: cyan,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Ynamly hyzmat  •  7/24',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              color: const Color(0xFF0D1C2D),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xFF1D4669),
              ),
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 20),
        children: [
          const Header(),

          Padding(
            padding: const EdgeInsets.fromLTRB(18, 2, 18, 9),
            child: Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 8,
                  color: green,
                ),
                const SizedBox(width: 7),
                const Expanded(
                  child: Text(
                    'Siziň telefon hyzmatlaryňyz bizde!',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: white,
                    ),
                  ),
                ),
                const Text(
                  '+90 501 687 3001',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const RepairBanner(),

          const Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 11),
            child: Row(
              children: [
                Text(
                  'Hyzmatlar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Spacer(),
                Text(
                  'Hemmesini gör  →',
                  style: TextStyle(
                    fontSize: 12,
                    color: cyan,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 11,
              mainAxisSpacing: 11,
              childAspectRatio: .98,
              children: [
                ServiceCard(
                  icon: Icons.phone_android_rounded,
                  title: 'Telefon bejertmek',
                  subtitle: 'Çalt we ygtybarly',
                  onTap: () => open(
                    context,
                    const RepairPage(),
                  ),
                ),
                ServiceCard(
                  icon: Icons.assignment_rounded,
                  title: 'Arzalarym',
                  subtitle: 'Arzalaryňyzy görüň',
                  onTap: () => open(
                    context,
                    const RequestsPage(),
                  ),
                ),
                ServiceCard(
                  icon: Icons.payments_rounded,
                  title: 'Bahalar',
                  subtitle: 'Hyzmat bahalary',
                  onTap: () => open(
                    context,
                    const PricesPage(),
                  ),
                ),
                ServiceCard(
                  icon: Icons.headphones_rounded,
                  title: 'Aksessuarlar',
                  subtitle: 'Gün görnüşli harytlar',
                  onTap: () => open(
                    context,
                    const AccessoriesPage(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF062824),
                  Color(0xFF07191E),
                ],
              ),
              border: Border.all(
                color: const Color(0xFF14685D),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 51,
                  height: 51,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: green,
                  ),
                  child: const Icon(
                    Icons.chat_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WhatsApp arkaly habarlaşyň',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Soraglaryňyz üçin elmydama ýazyň.',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: sub,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Clipboard.setData(
                      const ClipboardData(
                        text: '+905016873001',
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'WhatsApp nomeri göçürildi',
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    'Habarlaş',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RepairBanner extends StatelessWidget {
  const RepairBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      padding: const EdgeInsets.fromLTRB(
        20,
        17,
        16,
        17,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0E5EB1),
            Color(0xFF087CF2),
            Color(0xFF082D58),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF31B8FF),
        ),
        boxShadow: [
          BoxShadow(
            color: blue.withOpacity(.23),
            blurRadius: 28,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.phone_iphone_rounded,
              size: 180,
              color: Colors.white.withOpacity(.12),
            ),
          ),
          Positioned(
            right: 25,
            bottom: 34,
            child: Transform.rotate(
              angle: -.65,
              child: const Icon(
                Icons.build_rounded,
                size: 65,
                color: Colors.white70,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(.12),
                  border: Border.all(
                    color: Colors.white70,
                  ),
                ),
                child: const Text(
                  'PROFESSIONAL HYZMAT',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'TELEFON',
                style: TextStyle(
                  fontSize: 30,
                  height: .95,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'BEJERTMEK',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Arzaňyzy aňsat we çalt iberiň!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RepairPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 19,
                ),
                label: const Text(
                  'Arza ber',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(23),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF122A45),
              Color(0xFF091523),
            ],
          ),
          border: Border.all(
            color: const Color(0xFF174B75),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.22),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1A5B8C),
                    Color(0xFF071522),
                  ],
                ),
                border: Border.all(
                  color: cyan.withOpacity(.65),
                ),
                boxShadow: [
                  BoxShadow(
                    color: cyan.withOpacity(.15),
                    blurRadius: 18,
                  ),
                ],
              ),
