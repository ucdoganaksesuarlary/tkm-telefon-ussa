import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TkmApp());
}

const blue = Color(0xFF1597FF);
const cyan = Color(0xFF39C6FF);
const bg = Color(0xFF070A10);
const card = Color(0xFF101722);
const card2 = Color(0xFF151D29);

class TkmApp extends StatelessWidget {
  const TkmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM TELEFON USSA',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: card,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.white.withOpacity(.06)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: blue, width: 1.4),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class Repair {
  final String name, phone, model, problem, details;
  final String? photo;
  String status;
  Repair({
    required this.name,
    required this.phone,
    required this.model,
    required this.problem,
    required this.details,
    this.photo,
    this.status = 'Garaşylýar',
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  final List<Repair> repairs = [];
  final List<String> services = [
    'Ekran çalyşmak',
    'Batareýa çalyşmak',
    'Zarýad soketi',
    'Arka gapak',
    'Kamera bejergisi',
    'Programma üpjünçiligi',
  ];
  final List<String> accessories = [
    'Gorag aýnasy',
    'Telefon çeholy',
    'Zarýadnik',
    'USB kabel',
    'Bluetooth nauşnik',
    'Powerbank',
    'Smart sagat',
    'Kolonka',
  ];

  void openRepair() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RepairPage(
          onSend: (r) => setState(() => repairs.add(r)),
        ),
      ),
    );
  }

  void showAdmin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdminLoginPage(
          repairs: repairs,
          services: services,
          accessories: accessories,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(
        repairs: repairs,
        onRepair: openRepair,
        onRequests: () => setState(() => tab = 1),
        onPrices: () => setState(() => tab = 3),
        onAccessories: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AccessoriesPage(items: accessories)),
        ),
      ),
      RequestsPage(repairs: repairs),
      RepairPage(onSend: (r) => setState(() => repairs.add(r))),
      PricesPage(items: services),
      ProfilePage(onAdmin: showAdmin),
    ];

    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF0E131B),
        indicatorColor: blue.withOpacity(.22),
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Baş sahypa'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), selectedIcon: Icon(Icons.assignment_rounded), label: 'Arzalar'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), selectedIcon: Icon(Icons.add_circle), label: 'Arza'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), selectedIcon: Icon(Icons.payments_rounded), label: 'Bahalar'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Repair> repairs;
  final VoidCallback onRepair, onRequests, onPrices, onAccessories;
  const HomeContent({
    super.key,
    required this.repairs,
    required this.onRepair,
    required this.onRequests,
    required this.onPrices,
    required this.onAccessories,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          const SizedBox(height: 22),
          const Text(
            'Telefon meseläňiz üçin\nbir ýerde!',
            style: TextStyle(fontSize: 31, height: 1.08, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          RepairBanner(onTap: onRepair),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hyzmatlar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              Text('${repairs.length} arza', style: const TextStyle(color: Colors.white54)),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: .98,
            children: [
              ServiceCard(Icons.phone_android_rounded, 'Telefon bejertmek', 'Çalt we ygtybarly', onRepair),
              ServiceCard(Icons.assignment_rounded, 'Arzalarym', 'Arzalaryňyzy görüň', onRequests),
              ServiceCard(Icons.payments_rounded, 'Bahalar', 'Hyzmat bahalary', onPrices),
              ServiceCard(Icons.shopping_bag_rounded, 'Aksessuarlar', 'Gün görnüşli harytlar', onAccessories),
            ],
          ),
          const SizedBox(height: 14),
          const ContactCard(),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [Color(0xFF123D62), Color(0xFF08111C)]),
            border: Border.all(color: cyan, width: 1.8),
            boxShadow: [BoxShadow(color: blue.withOpacity(.25), blurRadius: 20)],
          ),
          child: const Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.phone_iphone_rounded, size: 34),
              Positioned(right: 5, bottom: 5, child: Icon(Icons.build_rounded, size: 21, color: cyan)),
            ],
          ),
        ),
        const SizedBox(width: 11),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TKM', style: TextStyle(fontSize: 28, height: .9, fontWeight: FontWeight.w900)),
              Text('TELEFON USSA', style: TextStyle(fontSize: 15, color: cyan, fontWeight: FontWeight.w900)),
              SizedBox(height: 3),
              Text('Ynamly hyzmat • 7/24', style: TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(color: card, shape: BoxShape.circle),
          child: IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Täze bildiriş ýok.')),
            ),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ),
      ],
    );
  }
}

class RepairBanner extends StatelessWidget {
  final VoidCallback onTap;
  const RepairBanner({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF119BFF), Color(0xFF0754D7)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [BoxShadow(color: blue.withOpacity(.22), blurRadius: 28, offset: const Offset(0, 12))],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.build_rounded, color: blue, size: 31),
                  ),
                  const SizedBox(height: 20),
                  const Text('TELEFON BEJERTMEK', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 7),
                  const Text('Arzaňyzy aňsat we çalt iberiň!', style: TextStyle(fontSize: 15, color: Colors.white70)),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                    child: const Text('Arza ber  →', style: TextStyle(color: blue, fontSize: 16, fontWeight: FontWeight.w900)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.phone_android_rounded, size: 105, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const ServiceCard(this.icon, this.title, this.subtitle, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: blue.withOpacity(.10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: blue.withOpacity(.12),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: blue.withOpacity(.22)),
              ),
              child: Icon(icon, color: cyan, size: 31),
            ),
            const Spacer(),
            Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.white54)),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF092016),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.greenAccent.withOpacity(.18)),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat_rounded, color: Colors.greenAccent, size: 32),
          const SizedBox(width: 13),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WhatsApp arkaly habarlaşyň', style: TextStyle(fontWeight: FontWeight.w900)),
                SizedBox(height: 3),
                Text('Soraglaryňyz üçin elmydama ýazyň.', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              Clipboard.setData(const ClipboardData(text: '+905016873001'));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('WhatsApp belgisi göçürildi.')));
            },
            child: const Text('Habarlaş'),
          ),
        ],
      ),
    );
  }
}

class RepairPage extends StatefulWidget {
  final ValueChanged<Repair> onSend;
  const RepairPage({super.key, required this.onSend});
  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final model = TextEditingController();
  final problem = TextEditingController();
  final details = TextEditingController();
  String type = 'Ekran döwüldi';
  File? photo;

  Future<void> choosePhoto() async {
    final x = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (x != null) setState(() => photo = File(x.path));
  }

  void send() {
    if (name.text.trim().isEmpty || phone.text.trim().isEmpty || model.text.trim().isEmpty || problem.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gerekli ýerleri dolduryň.')));
      return;
    }
    widget.onSend(Repair(
      name: name.text.trim(),
      phone: phone.text.trim(),
      model: model.text.trim(),
      problem: type,
      details: problem.text.trim(),
      photo: photo?.path,
    ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Arzaňyz üstünlikli iberildi!')));
    Navigator.pop(context);
  }

  Widget field(String label, String hint, IconData icon, TextEditingController c, {TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label, hintText: hint, prefixIcon: Icon(icon)),
      ),
    );
  }

  @override
  void dispose() {
    name.dispose(); phone.dispose(); model.dispose(); problem.dispose(); details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arza goşmak', style: TextStyle(fontWeight: FontWeight.w900))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [blue.withOpacity(.18), card]),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: blue.withOpacity(.18)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.handyman_rounded, color: cyan, size: 34),
                  SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Arza beriň', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
                    SizedBox(height: 3),
                    Text('Telefon meseläňizi ýazyp, ussa iberiň.', style: TextStyle(color: Colors.white54)),
                  ])),
                ],
              ),
            ),
            const SizedBox(height: 20),
            field('Adyňyz', 'Adyňyzy ýazyň', Icons.person_outline_rounded, name),
            field('Telefon belgiňiz', '+90 ...', Icons.phone_rounded, phone, keyboard: TextInputType.phone),
            field('Telefon modeli', 'Meselem: iPhone 13 Pro', Icons.phone_android_rounded, model),
            const Text('Näsazlyk', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: type,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.build_rounded)),
              items: const [
                'Ekran döwüldi','Sensor işlemeýär','Telefon açylmaýar','Zarýad almaýar',
                'Batareýa','Kamera','Ses problemi','Wi-Fi / Internet','Başga',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => type = v!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: problem,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Problema barada düşündiriş', hintText: 'Telefonda näme problema bar?'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: details,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Goşmaça maglumat', hintText: 'Islendik goşmaça maglumat'),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: choosePhoto,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: card,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: blue.withOpacity(.20)),
                ),
                child: Column(
                  children: [
                    if (photo != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(photo!, height: 190, width: double.infinity, fit: BoxFit.cover),
                      )
                    else
                      const Icon(Icons.add_a_photo_rounded, color: cyan, size: 48),
                    const SizedBox(height: 10),
                    Text(photo == null ? 'Telefonyň suratyny goş' : 'Surat saýlandy ✓',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    const Text('Galereýadan surat saýlaň.', style: TextStyle(color: Colors.white54)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 58,
              child: FilledButton.icon(
                onPressed: send,
                icon: const Icon(Icons.send_rounded),
                label: const Text('ARZANY IBER', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RequestsPage extends StatelessWidget {
  final List<Repair> repairs;
  const RequestsPage({super.key, required this.repairs});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Arzalarym', style: TextStyle(fontWeight: FontWeight.w900))),
      body: repairs.isEmpty
          ? const EmptyState(icon: Icons.inbox_rounded, title: 'Häzirlikçe arza ýok', text: 'Täze arza bermek üçin “Arza” bölümine giriň.')
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: repairs.length,
              itemBuilder: (_, i) {
                final r = repairs[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(.06))),
                  child: Row(
                    children: [
                      Container(
                        width: 52, height: 52,
                        decoration: BoxDecoration(color: blue.withOpacity(.12), borderRadius: BorderRadius.circular(15)),
                        child: const Icon(Icons.phone_android_rounded, color: cyan),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(r.model, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text(r.problem, style: const TextStyle(color: Colors.white70)),
                        Text('${r.name} • ${r.phone}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                      ])),
                      StatusChip(r.status),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final String text;
  const StatusChip(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    final done = text == 'Tamamlandy';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
        color: (done ? Colors.greenAccent : Colors.orangeAccent).withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: TextStyle(color: done ? Colors.greenAccent : Colors.orangeAccent, fontSize: 10, fontWeight: FontWeight.w900)),
    );
  }
}

class PricesPage extends StatelessWidget {
  final List<String> items;
  const PricesPage({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bahalar', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: items.length,
        itemBuilder: (_, i) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(19)),
          child: ListTile(
            leading: const Icon(Icons.payments_rounded, color: cyan),
            title: Text(items[i], style: const TextStyle(fontWeight: FontWeight.w800)),
            subtitle: const Text('Bahasy modele görä kesgitlenýär'),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
        ),
      ),
    );
  }
}

class AccessoriesPage extends StatelessWidget {
  final List<String> items;
  const AccessoriesPage({super.key, required this.items});
  IconData iconFor(String s) {
    if (s.contains('aýna')) return Icons.layers_rounded;
    if (s.contains('çehol')) return Icons.phone_iphone_rounded;
    if (s.contains('Zarýad')) return Icons.power_rounded;
    if (s.contains('kabel')) return Icons.usb_rounded;
    if (s.contains('nauşnik')) return Icons.headphones_rounded;
    if (s.contains('Powerbank')) return Icons.battery_charging_full_rounded;
    if (s.contains('sagat')) return Icons.watch_rounded;
    return Icons.speaker_rounded;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aksessuarlar', style: TextStyle(fontWeight: FontWeight.w900))),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: .95),
        itemCount: items.length,
        itemBuilder: (_, i) => Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(22), border: Border.all(color: blue.withOpacity(.08))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Center(child: Icon(iconFor(items[i]), size: 55, color: cyan))),
              Text(items[i], style: const TextStyle(fontWeight: FontWeight.w900)),
              const SizedBox(height: 3),
              const Text('Baha üçin habarlaşyň', style: TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final VoidCallback onAdmin;
  const ProfilePage({super.key, required this.onAdmin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil', style: TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF0E2941), Color(0xFF0C1119)]),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: cyan.withOpacity(.25)),
            ),
            child: const Column(
              children: [
                CircleAvatar(radius: 47, backgroundColor: bg, child: Icon(Icons.handyman_rounded, color: cyan, size: 45)),
                SizedBox(height: 12),
                Text('TKM TELEFON USSA', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                SizedBox(height: 4),
                Text('Ynamly hyzmat • 7/24', style: TextStyle(color: Colors.white54)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ListTile(leading: Icon(Icons.phone_rounded, color: cyan), title: Text('+905016873001'), subtitle: Text('Habarlaşmak')),
          const ListTile(leading: Icon(Icons.access_time_rounded, color: cyan), title: Text('7/24 hyzmatda'), subtitle: Text('Iş wagty')),
          const ListTile(leading: Icon(Icons.verified_rounded, color: cyan), title: Text('Ynamly we çalt'), subtitle: Text('Hyzmat')),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: onAdmin,
            icon: const Icon(Icons.admin_panel_settings_rounded),
            label: const Text('ADMIN PANEL'),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title, text;
  const EmptyState({super.key, required this.icon, required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 70, color: blue.withOpacity(.7)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(text, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54)),
        ]),
      ),
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  final List<Repair> repairs;
  final List<String> services, accessories;
  const AdminLoginPage({super.key, required this.repairs, required this.services, required this.accessories});
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final pass = TextEditingController();
  void login() {
    if (pass.text == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AdminPage(repairs: widget.repairs, services: widget.services, accessories: widget.accessories),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Admin kody nädogry.')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin giriş')),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.admin_panel_settings_rounded, color: cyan, size: 75),
            const SizedBox(height: 18),
            const Text('ADMIN PANEL', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
            const SizedBox(height: 25),
            TextField(controller: pass, obscureText: true, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Admin kody', prefixIcon: Icon(Icons.lock_rounded))),
            const SizedBox(height: 15),
            SizedBox(width: double.infinity, height: 55, child: FilledButton(onPressed: login, child: const Text('GIRMEK'))),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() { pass.dispose(); super.dispose(); }
}

class AdminPage extends StatefulWidget {
  final List<Repair> repairs;
  final List<String> services, accessories;
  const AdminPage({super.key, required this.repairs, required this.services, required this.accessories});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selected = 0;
  final priceController = TextEditingController();
  final productController = TextEditingController();

  @override
  void dispose() { priceController.dispose(); productController.dispose(); super.dispose(); }

  Widget stat(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: cyan),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ]),
      ),
    );
  }

  void addService() {
    final v = priceController.text.trim();
    if (v.isNotEmpty) {
      setState(() => widget.services.add(v));
      priceController.clear();
    }
  }

  void addProduct() {
    final v = productController.text.trim();
    if (v.isNotEmpty) {
      setState(() => widget.accessories.add(v));
      productController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = [
      _dashboard(),
      _requests(),
      _prices(),
      _products(),
      _settings(),
    ][selected];

    return Scaffold(
      appBar: AppBar(
        title: const Text('TKM ADMIN', style: TextStyle(fontWeight: FontWeight.w900)),
        actions: [IconButton(onPressed: () => setState(() {}), icon: const Icon(Icons.refresh_rounded))],
      ),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (i) => setState(() => selected = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Panel'),
          NavigationDestination(icon: Icon(Icons.assignment_outlined), label: 'Arzalar'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), label: 'Bahalar'),
          NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), label: 'Harytlar'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Sazlama'),
        ],
      ),
    );
  }

  Widget _dashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Dolandyryş paneli', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
        const SizedBox(height: 6),
        const Text('Arzalary, bahalary we harytlary şu ýerden dolandyryň.', style: TextStyle(color: Colors.white54)),
        const SizedBox(height: 18),
        Row(children: [
          stat('Jemi arza', '${widget.repairs.length}', Icons.assignment_rounded),
          const SizedBox(width: 10),
          stat('Garaşylýar', '${widget.repairs.where((e) => e.status == 'Garaşylýar').length}', Icons.pending_actions_rounded),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          stat('Hyzmat', '${widget.services.length}', Icons.build_rounded),
          const SizedBox(width: 10),
          stat('Haryt', '${widget.accessories.length}', Icons.shopping_bag_rounded),
        ]),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF0C3760), Color(0xFF0A1623)]),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(Icons.security_rounded, color: cyan, size: 34),
            SizedBox(height: 10),
            Text('Admin ulgamy taýýar', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
            SizedBox(height: 4),
            Text('Bu wersiýada maglumatlar telefonda wagtlaýyn saklanýar. Online maglumat bazasy soň birikdirilip bilner.', style: TextStyle(color: Colors.white60)),
          ]),
        ),
      ],
    );
  }

  Widget _requests() {
    if (widget.repairs.isEmpty) {
      return const EmptyState(icon: Icons.inbox_rounded, title: 'Arza ýok', text: 'Müşderiler arza iberende şu ýerde görüner.');
    }
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: widget.repairs.length,
      itemBuilder: (_, i) {
        final r = widget.repairs[i];
        return Card(
          color: card,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(child: Text(r.model, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900))),
                DropdownButton<String>(
                  value: r.status,
                  items: const ['Garaşylýar', 'Bejerilýär', 'Tamamlandy']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => r.status = v!),
                ),
              ]),
              Text('${r.name} • ${r.phone}'),
              const SizedBox(height: 4),
              Text('${r.problem}: ${r.details}', style: const TextStyle(color: Colors.white60)),
              if (r.photo != null) ...[
                const SizedBox(height: 10),
                ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(File(r.photo!), height: 120, width: double.infinity, fit: BoxFit.cover)),
              ],
            ]),
          ),
        );
      },
    );
  }

  Widget _prices() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text('Hyzmatlar / bahalar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: TextField(controller: priceController, decoration: const InputDecoration(hintText: 'Täze hyzmat goşuň'))),
          const SizedBox(width: 8),
          IconButton.filled(onPressed: addService, icon: const Icon(Icons.add)),
        ]),
        const SizedBox(height: 12),
        ...widget.services.asMap().entries.map((e) => Card(
          color: card,
          child: ListTile(
            leading: const Icon(Icons.build_rounded, color: cyan),
            title: Text(e.value),
            trailing: IconButton(onPressed: () => setState(() => widget.services.removeAt(e.key)), icon: const Icon(Icons.delete_outline, color: Colors.redAccent)),
          ),
        )),
      ],
    );
  }

  Widget _products() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text('Aksessuarlar / harytlar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: TextField(controller: productController, decoration: const InputDecoration(hintText: 'Täze haryt goşuň'))),
          const SizedBox(width: 8),
          IconButton.filled(onPressed: addProduct, icon: const Icon(Icons.add)),
        ]),
        const SizedBox(height: 12),
        ...widget.accessories.asMap().entries.map((e) => Card(
          color: card,
          child: ListTile(
            leading: const Icon(Icons.shopping_bag_rounded, color: cyan),
            title: Text(e.value),
            trailing: IconButton(onPressed: () => setState(() => widget.accessories.removeAt(e.key)), icon: const Icon(Icons.delete_outline, color: Colors.redAccent)),
          ),
        )),
      ],
    );
  }

  Widget _settings() {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        const Text('Sazlamalar', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        const Card(child: ListTile(leading: Icon(Icons.lock_rounded, color: cyan), title: Text('Admin kody'), subtitle: Text('Häzirki demo kod: 1234'))),
        const Card(child: ListTile(leading: Icon(Icons.notifications_rounded, color: cyan), title: Text('Bildirişler'), subtitle: Text('Soňra online bildiriş ulgamy birikdiriler'))),
        const Card(child: ListTile(leading: Icon(Icons.cloud_rounded, color: cyan), title: Text('Online maglumat bazasy'), subtitle: Text('Indiki ädimde Firebase ýaly ulgam goşup bolýar'))),
      ],
    );
  }
}
