import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bg = Color(0xFF050B14);
const card = Color(0xFF0D1F33);
const blue = Color(0xFF109BFF);
const cyan = Color(0xFF62D0FF);
const muted = Color(0xFF9AAEC3);
const green = Color(0xFF19D67A);

void main() {
  runApp(const TkmApp());
}

class TkmApp extends StatelessWidget {
  const TkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM Telefon Ussa',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int tab = 0;

  final pages = const [
    HomeScreen(),
    RequestsScreen(),
    RepairScreen(),
    PricesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavigationBar(
        height: 72,
        backgroundColor: const Color(0xFF09121E),
        indicatorColor: const Color(0xFF173653),
        selectedIndex: tab,
        onDestinationSelected: (value) {
          setState(() {
            tab = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: cyan),
            label: 'Baş sahypa',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(Icons.assignment_rounded, color: cyan),
            label: 'Arzalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle, color: cyan),
            label: 'Arza',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            selectedIcon: Icon(Icons.payments_rounded, color: cyan),
            label: 'Bahalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_rounded, color: cyan),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 18),
        children: [
          const Header(),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 2, 18, 10),
            child: Row(
              children: [
                Icon(Icons.circle, size: 8, color: green),
                SizedBox(width: 7),
                Expanded(
                  child: Text(
                    'Siziň telefon hyzmatlaryňyz bizde!',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                Text(
                  '+90 501 687 3001',
                  style: TextStyle(
                    fontSize: 10,
                    color: cyan,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          RepairBanner(
            onTap: () => open(context, const RepairScreen()),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 11),
            child: Text(
              'Hyzmatlar',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
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
              childAspectRatio: 0.98,
              children: [
                ServiceCard(
                  icon: Icons.phone_android_rounded,
                  title: 'Telefon bejertmek',
                  subtitle: 'Çalt we ygtybarly',
                  onTap: () => open(context, const RepairScreen()),
                ),
                ServiceCard(
                  icon: Icons.assignment_rounded,
                  title: 'Arzalarym',
                  subtitle: 'Arzalaryňyzy görüň',
                  onTap: () => open(context, const RequestsScreen()),
                ),
                ServiceCard(
                  icon: Icons.payments_rounded,
                  title: 'Bahalar',
                  subtitle: 'Hyzmat bahalary',
                  onTap: () => open(context, const PricesScreen()),
                ),
                ServiceCard(
                  icon: Icons.headphones_rounded,
                  title: 'Aksessuarlar',
                  subtitle: 'Gün görnüşli harytlar',
                  onTap: () => open(context, const AccessoriesScreen()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const WhatsAppCard(),
        ],
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
                colors: [Color(0xFF10436A), Color(0xFF071321)],
              ),
              border: Border.all(color: cyan, width: 2),
              boxShadow: [
                BoxShadow(color: blue.withOpacity(.35), blurRadius: 20),
              ],
            ),
            child: const Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.phone_iphone_rounded, size: 39),
                Positioned(
                  right: 9,
                  bottom: 8,
                  child: Icon(Icons.build_rounded, size: 23, color: cyan),
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
                  style: TextStyle(fontSize: 10),
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
              border: Border.all(color: const Color(0xFF1D4669)),
            ),
            child: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
    );
  }
}

class RepairBanner extends StatelessWidget {
  final VoidCallback onTap;

  const RepairBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          colors: [Color(0xFF0C5CAE), Color(0xFF087CF2), Color(0xFF082C55)],
        ),
        border: Border.all(color: const Color(0xFF31B8FF)),
        boxShadow: [
          BoxShadow(color: blue.withOpacity(.22), blurRadius: 25),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -25,
            child: Icon(
              Icons.phone_iphone_rounded,
              size: 175,
              color: Colors.white.withOpacity(.12),
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
                  border: Border.all(color: Colors.white70),
                ),
                child: const Text(
                  'PROFESSIONAL HYZMAT',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                'TELEFON',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const Text(
                'BEJERTMEK',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Arzaňyzy aňsat we çalt iberiň!',
                style: TextStyle(fontSize: 13),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: onTap,
                icon: const Icon(Icons.arrow_forward_rounded, size: 19),
                label: const Text(
                  'Arza ber',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
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
            colors: [Color(0xFF122A45), Color(0xFF091523)],
          ),
          border: Border.all(color: const Color(0xFF174B75)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF195A8B), Color(0xFF071522)],
                ),
                border: Border.all(color: cyan.withOpacity(.65)),
                boxShadow: [
                  BoxShadow(color: cyan.withOpacity(.14), blurRadius: 16),
                ],
              ),
              child: Icon(icon, size: 42, color: cyan),
            ),
            const SizedBox(height: 9),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: muted),
            ),
            const SizedBox(height: 4),
            const Icon(Icons.arrow_forward_rounded, size: 17, color: cyan),
          ],
        ),
      ),
    );
  }
}

class WhatsAppCard extends StatelessWidget {
  const WhatsAppCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF071F1E),
        border: Border.all(color: const Color(0xFF14685D)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: green,
            child: Icon(Icons.chat_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 11),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WhatsApp arkaly habarlaşyň',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 3),
                Text(
                  'Soraglaryňyz üçin elmydama ýazyň.',
                  style: TextStyle(fontSize: 10, color: muted),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              Clipboard.setData(
                const ClipboardData(text: '+905016873001'),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nomeri göçürildi')),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: green),
            child: const Text('Habarlaş'),
          ),
        ],
      ),
    );
  }
}

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  final model = TextEditingController();
  final problem = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();

  void submit() {
    if (model.text.trim().isEmpty ||
        problem.text.trim().isEmpty ||
        name.text.trim().isEmpty ||
        phone.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ähli meýdançany dolduryň')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Arzaňyz üstünlikli iberildi!'),
        backgroundColor: blue,
      ),
    );

    model.clear();
    problem.clear();
    name.clear();
    phone.clear();
  }

  @override
  void dispose() {
    model.dispose();
    problem.dispose();
    name.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefon bejertmek',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          const IntroCard(
            icon: Icons.build_rounded,
            title: 'Arza beriň',
            description: 'Telefon meseläňizi ýazyp, ussa iberiň.',
          ),
          const SizedBox(height: 15),
          InputField(
            controller: model,
            label: 'Telefon modeli',
            hint: 'Mysal: iPhone 13 Pro',
            icon: Icons.phone_android_rounded,
          ),
          const SizedBox(height: 11),
          InputField(
            controller: problem,
            label: 'Näsazlyk / mesele',
            hint: 'Telefon näme problema berýär?',
            icon: Icons.report_problem_rounded,
            maxLines: 4,
          ),
          const SizedBox(height: 11),
          InputField(
            controller: name,
            label: 'Adyňyz',
            hint: 'Adyňyzy ýazyň',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 11),
          InputField(
            controller: phone,
            label: 'Telefon belgiňiz',
            hint: '+90 ...',
            icon: Icons.phone_rounded,
            keyboard: TextInputType.phone,
          ),
          const SizedBox(height: 17),
          SizedBox(
            height: 53,
            child: FilledButton.icon(
              onPressed: submit,
              icon: const Icon(Icons.send_rounded),
              label: const Text(
                'Arzany iber',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;
  final TextInputType? keyboard;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboard,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: cyan),
        filled: true,
        fillColor: const Color(0xFF0A1828),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF173B5B)),
        ),
      ),
    );
  }
}

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleScreen(
      title: 'Arzalarym',
      icon: Icons.assignment_rounded,
      description: 'Berlen arzalaryňyzy şu ýerden görüp bilersiňiz.',
      child: EmptyState(),
    );
  }
}

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      'Ekran çalyşmak',
      'Batareýa çalyşmak',
      'Zarýad soketi',
      'Kamera bejergisi',
      'Programma üpjünçiligi',
    ];

    return SimpleScreen(
      title: 'Bahalar',
      icon: Icons.payments_rounded,
      description: 'Takyk baha telefon modeline görä kesgitlenýär.',
      child: Column(
        children: items
            .map(
              (item) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 9),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(color: const Color(0xFF173D60)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle_rounded, color: cyan),
                    const SizedBox(width: 11),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Text(
                      'Modeline görä',
                      style: TextStyle(fontSize: 10, color: muted),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ['Gorag aýnasy', Icons.phone_iphone_rounded],
      ['Telefon çehi', Icons.phone_android_rounded],
      ['Zarýadnik / kabel', Icons.power_rounded],
      ['Bluetooth nauşnik', Icons.headphones_rounded],
      ['Powerbank', Icons.battery_charging_full_rounded],
      ['Kolonka', Icons.speaker_rounded],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aksessuarlar',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 11,
          mainAxisSpacing: 11,
          childAspectRatio: .94,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21),
              gradient: const LinearGradient(
                colors: [Color(0xFF122A45), Color(0xFF091523)],
              ),
              border: Border.all(color: const Color(0xFF17466F)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  items[index][1] as IconData,
                  size: 48,
                  color: cyan,
                ),
                const SizedBox(height: 11),
                Text(
                  items[index][0] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Haryt barada sora',
                  style: TextStyle(fontSize: 10, color: muted),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleScreen(
      title: 'Profil',
      icon: Icons.person_rounded,
      description: 'TKM Telefon Ussa • 7/24 hyzmatda',
      child: Column(
        children: [
          InfoRow(
            icon: Icons.phone_rounded,
            title: 'Habarlaşmak',
            value: '+90 501 687 3001',
          ),
          InfoRow(
            icon: Icons.access_time_rounded,
            title: 'Iş wagty',
            value: '7/24 hyzmatda',
          ),
          InfoRow(
            icon: Icons.verified_rounded,
            title: 'Hyzmat',
            value: 'Ynamly we çalt',
          ),
        ],
      ),
    );
  }
}

class SimpleScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;
  final Widget child;

  const SimpleScreen({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          IntroCard(
            icon: icon,
            title: title,
            description: description,
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}

class IntroCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const IntroCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF112B47), Color(0xFF091624)],
        ),
        border: Border.all(color: const Color(0xFF174C78)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0A3559),
              border: Border.all(color: blue),
            ),
            child: Icon(icon, color: cyan, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 10.5, color: muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF091725),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF173D60)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inbox_rounded,
            size: 55,
            color: Color(0xFF52708B),
          ),
          SizedBox(height: 12),
          Text(
            'Häzirlikçe arza ýok',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Täze arza bermek üçin “Arza” bölümine giriň.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: muted),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFF173D60)),
      ),
      child: Row(
        children: [
          Icon(icon, color: cyan, size: 27),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: cyan),
        ],
      ),
    );
  }
}
