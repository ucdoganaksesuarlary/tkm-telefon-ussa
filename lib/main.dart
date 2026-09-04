import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

const bg = Color(0xFF050B14);
const card = Color(0xFF0B192A);
const card2 = Color(0xFF10253D);
const blue = Color(0xFF129BFF);
const cyan = Color(0xFF63D1FF);
const text = Color(0xFFF4F8FF);
const sub = Color(0xFF9AAEC3);
const green = Color(0xFF19D67A);

void main() => runApp(const TkmTelefonUssa());

class TkmTelefonUssa extends StatelessWidget {
  const TkmTelefonUssa({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM TELEFON USSA',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: blue, brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int tab = 0;
  final pages = const [Home(), Requests(), Repair(), Prices(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tab, children: pages),
      bottomNavigationBar: NavBar(
        current: tab,
        onTap: (v) => setState(() => tab = v),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final int current;
  final ValueChanged<int> onTap;
  const NavBar({super.key, required this.current, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const labels = ['Baş sahypa', 'Arzalar', 'Arza', 'Bahalar', 'Profil'];
    const icons = [
      Icons.home_rounded,
      Icons.assignment_rounded,
      Icons.add_rounded,
      Icons.payments_rounded,
      Icons.person_rounded,
    ];
    return Container(
      height: 78,
      decoration: const BoxDecoration(
        color: Color(0xFF09121E),
        border: Border(top: BorderSide(color: Color(0xFF17314C))),
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
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0879FF), Color(0xFF54D2FF)],
                          ),
                          boxShadow: [
                            BoxShadow(color: blue.withOpacity(.45), blurRadius: 18),
                          ],
                        ),
                        child: const Icon(Icons.add_rounded, size: 27),
                      )
                    else
                      Icon(
                        icons[i],
                        size: 24,
                        color: selected ? cyan : const Color(0xFFBBC8D6),
                      ),
                    const SizedBox(height: 3),
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                        color: selected ? cyan : const Color(0xFFBBC8D6),
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

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Row(
        children: [
          Container(
            width: 67,
            height: 67,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF0C365B), Color(0xFF071321)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: cyan, width: 2),
              boxShadow: [
                BoxShadow(color: blue.withOpacity(.35), blurRadius: 20),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.phone_iphone_rounded, size: 38, color: text),
                Transform.translate(
                  offset: const Offset(7, 8),
                  child: Transform.rotate(
                    angle: -.55,
                    child: const Icon(Icons.build_rounded, size: 23, color: cyan),
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
                Text('TKM', style: TextStyle(fontSize: 30, height: .85, fontWeight: FontWeight.w900)),
                Text('TELEFON USSA',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: cyan)),
                SizedBox(height: 4),
                Text('Ynamly hyzmat  •  7/24',
                    style: TextStyle(fontSize: 10.5, color: text, fontWeight: FontWeight.w600)),
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
            child: const Icon(Icons.notifications_none_rounded, size: 25),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  void go(BuildContext c, Widget page) {
    Navigator.push(c, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.only(bottom: 18),
        children: [
          const BrandHeader(),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 2, 18, 9),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: green),
                const SizedBox(width: 7),
                const Expanded(
                  child: Text('Siziň telefon hyzmatlaryňyz bizde!',
                      style: TextStyle(fontSize: 12.5, color: text)),
                ),
                const Text('+90 501 687 3001',
                    style: TextStyle(fontSize: 10.5, color: cyan, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const HeroRepair(),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 20, 18, 11),
            child: Row(
              children: [
                Text('Hyzmatlar',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                Spacer(),
                Text('Hemmesini gör  →',
                    style: TextStyle(fontSize: 12, color: cyan, fontWeight: FontWeight.w700)),
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
                PremiumService(
                  icon: Icons.phone_android_rounded,
                  accent: cyan,
                  title: 'Telefon bejertmek',
                  sub: 'Çalt we ygtybarly',
                  onTap: () => go(context, const Repair()),
                ),
                PremiumService(
                  icon: Icons.assignment_rounded,
                  accent: cyan,
                  title: 'Arzalarym',
                  sub: 'Arzalaryňyzy görüň',
                  onTap: () => go(context, const Requests()),
                ),
                PremiumService(
                  icon: Icons.payments_rounded,
                  accent: cyan,
                  title: 'Bahalar',
                  sub: 'Hyzmat bahalary',
                  onTap: () => go(context, const Prices()),
                ),
                PremiumService(
                  icon: Icons.headphones_rounded,
                  accent: cyan,
                  title: 'Aksessuarlar',
                  sub: 'Gün görnüşli harytlar',
                  onTap: () => go(context, const Accessories()),
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
                colors: [Color(0xFF062824), Color(0xFF07191E)],
              ),
              border: Border.all(color: const Color(0xFF14685D)),
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
                  child: const Icon(Icons.chat_rounded, size: 28, color: Colors.white),
                ),
                const SizedBox(width: 11),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('WhatsApp arkaly habarlaşyň',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                      SizedBox(height: 3),
                      Text('Soraglaryňyz üçin elmydama ýazyň.',
                          style: TextStyle(fontSize: 10.5, color: sub)),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: '+905016873001'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('WhatsApp nomeri göçürildi')),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: green,
                    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  ),
                  child: const Text('Habarlaş', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroRepair extends StatelessWidget {
  const HeroRepair({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 235,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      padding: const EdgeInsets.fromLTRB(20, 17, 16, 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0E5EB1), Color(0xFF087CF2), Color(0xFF082D58)],
        ),
        border: Border.all(color: const Color(0xFF31B8FF), width: .8),
        boxShadow: [
          BoxShadow(color: blue.withOpacity(.23), blurRadius: 28),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            bottom: -20,
            child: Transform.rotate(
              angle: -.18,
              child: Icon(Icons.phone_iphone_rounded,
                  size: 180, color: Colors.white.withOpacity(.12)),
            ),
          ),
          Positioned(
            right: 26,
            bottom: 35,
            child: Transform.rotate(
              angle: -.65,
              child: const Icon(Icons.build_rounded, size: 64, color: Colors.white70),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(.12),
                  border: Border.all(color: Colors.white70),
                ),
                child: const Text('PROFESSIONAL HYZMAT',
                    style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(height: 12),
              const Text('TELEFON',
                  style: TextStyle(fontSize: 30, height: .95, fontWeight: FontWeight.w900)),
              const Text('BEJERTMEK',
                  style: TextStyle(fontSize: 30, height: 1.05, fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              const Text('Arzaňyzy aňsat we çalt iberiň!',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Repair()),
                ),
                icon: const Icon(Icons.arrow_forward_rounded, size: 19),
                label: const Text('Arza ber',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: blue,
                  padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PremiumService extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final String title;
  final String sub;
  final VoidCallback onTap;

  const PremiumService({
    super.key,
    required this.icon,
    required this.accent,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(23),
      child: Container(
        padding: const EdgeInsets.fromLTRB(11, 14, 11, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF122A45), Color(0xFF091523)],
          ),
          border: Border.all(color: const Color(0xFF174B75)),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.22), blurRadius: 12, offset: const Offset(0, 5)),
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
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [const Color(0xFF1A5B8C), const Color(0xFF071522)],
                ),
                border: Border.all(color: accent.withOpacity(.65)),
                boxShadow: [
                  BoxShadow(color: accent.withOpacity(.15), blurRadius: 18),
                ],
              ),
              child: Icon(icon, size: 43, color: accent),
            ),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w900)),
            const SizedBox(height: 3),
            Text(sub,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10.5, color: sub)),
            const SizedBox(height: 4),
            Icon(Icons.arrow_forward_rounded, size: 17, color: accent),
          ],
        ),
      ),
    );
  }
}

class Repair extends StatefulWidget {
  const Repair({super.key});
  @override
  State<Repair> createState() => _RepairState();
}

class _RepairState extends State<Repair> {
  final model = TextEditingController();
  final problem = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  XFile? photo;

  Future<void> pick() async {
    final x = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (x != null) setState(() => photo = x);
  }

  void send() {
    if ([model, problem, name, phone].any((c) => c.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ähli meýdançany dolduryň')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Arzaňyz üstünlikli iberildi!'),
        backgroundColor: Color(0xFF087CF2),
      ),
    );
    model.clear();
    problem.clear();
    name.clear();
    phone.clear();
    setState(() => photo = null);
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
      appBar: AppBar(title: const Text('Telefon bejertmek',
          style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(17),
        children: [
          const Intro(icon: Icons.build_rounded, title: 'Arza beriň',
              text: 'Telefon meseläňizi ýazyp, ussa iberiň.'),
          const SizedBox(height: 15),
          Field(controller: model, label: 'Telefon modeli', hint: 'Mysal: iPhone 13 Pro',
              icon: Icons.phone_android_rounded),
          const SizedBox(height: 11),
          Field(controller: problem, label: 'Näsazlyk / mesele',
              hint: 'Telefon näme problema berýär?', icon: Icons.report_problem_rounded, lines: 4),
          const SizedBox(height: 11),
          OutlinedButton.icon(
            onPressed: pick,
            icon: const Icon(Icons.photo_camera_back_rounded),
            label: Text(photo == null ? 'Surat goş' : 'Surat saýlandy'),
            style: OutlinedButton.styleFrom(
              foregroundColor: cyan,
              side: const BorderSide(color: Color(0xFF1C6EA8)),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          if (photo != null) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(File(photo!.path), height: 170, fit: BoxFit.cover),
            ),
       
