import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0F1018),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Repair {
  final String name, phone, model, problem, details;
  final String? photo;
  Repair({
    required this.name,
    required this.phone,
    required this.model,
    required this.problem,
    required this.details,
    this.photo,
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

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(onRepair: openRepair),
      RequestsPage(repairs: repairs),
      RepairPage(onSend: (r) => setState(() => repairs.add(r))),
      const PricesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Baş sahypa'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), label: 'Arzalar'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline), label: 'Arza'),
          NavigationDestination(icon: Icon(Icons.payments_outlined), label: 'Bahalar'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback onRepair;
  const HomeContent({super.key, required this.onRepair});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('TKM TELEFON USSA',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Täze bildiriş ýok.')),
                ),
                icon: const Icon(Icons.notifications_none, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Telefon meseläňiz üçin bir\nýerde!',
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          InkWell(
            onTap: onRepair,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1688FF), Color(0xFF0759D6)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.build, color: Colors.blue, size: 38),
                  ),
                  const SizedBox(height: 25),
                  const Text('TELEFON BEJERTMEK',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Arzaňyzy aňsat we çalt iberiň!',
                      style: TextStyle(fontSize: 17)),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text('Arza ber →',
                        style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text('Hyzmatlar',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.05,
            children: [
              ServiceCard(Icons.build, 'Telefon bejertmek', onRepair),
              ServiceCard(Icons.list_alt, 'Arzalarym', () {}),
              ServiceCard(Icons.payments, 'Bahalar', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PricesPage()));
              }),
              ServiceCard(Icons.shopping_cart, 'Aksessuarlar', () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AccessoriesPage()));
              }),
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
  final VoidCallback onTap;
  const ServiceCard(this.icon, this.title, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF191D28),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 44),
            const SizedBox(height: 18),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          ],
        ),
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
    final x = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (x != null) setState(() => photo = File(x.path));
  }

  void send() {
    if (name.text.trim().isEmpty ||
        phone.text.trim().isEmpty ||
        model.text.trim().isEmpty ||
        problem.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gerekli ýerleri dolduryň.')),
      );
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Arzaňyz üstünlikli iberildi!')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    model.dispose();
    problem.dispose();
    details.dispose();
    super.dispose();
  }

  Widget field(String label, String hint, IconData icon, TextEditingController c,
      {TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: c,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: const Color(0xFF191D28),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telefon bejertmek',
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Telefon barada maglumat',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Maglumatlary dolduryp arzaňyzy iberiň.',
                style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(height: 25),
            field('Adyňyz', 'Adyňyzy ýazyň', Icons.person_outline, name),
            field('Telefon belgiňiz', 'Telefon belgiňiz', Icons.phone, phone,
                keyboard: TextInputType.phone),
            field('Telefon modeli', 'Meselem: iPhone 13 Pro',
                Icons.phone_android, model),
            const Text('Näsazlyk',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: type,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.build),
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
              items: const [
                'Ekran döwüldi',
                'Sensor işlemeýär',
                'Telefon açylmaýar',
                'Zarýad almaýar',
                'Batareýa',
                'Kamera',
                'Ses problemi',
                'Wi-Fi / Internet',
                'Başga',
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => type = v!),
            ),
            const SizedBox(height: 22),
            const Text('Problema barada düşündiriş',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: problem,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Telefonda näme problema bar?',
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Goşmaça maglumat',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: details,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Goşmaça maglumat',
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: choosePhoto,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF191D28),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    if (photo != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(photo!,
                            height: 180, width: double.infinity, fit: BoxFit.cover),
                      )
                    else
                      const Icon(Icons.add_a_photo, color: Colors.blue, size: 55),
                    const SizedBox(height: 12),
                    Text(photo == null ? '📷 Telefonyň suratyny goş' : 'Surat saýlandy ✓',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text('Galereýadan surat saýlaň.',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: FilledButton.icon(
                onPressed: send,
                icon: const Icon(Icons.send),
                label: const Text('ARZANY IBER',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 25),
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
      appBar: AppBar(title: const Text('Arzalarym',
          style: TextStyle(fontWeight: FontWeight.bold))),
      body: repairs.isEmpty
          ? const Center(child: Text('Häzirlikçe arza ýok',
              style: TextStyle(fontSize: 20)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: repairs.length,
              itemBuilder: (_, i) {
                final r = repairs[i];
                return Card(
                  color: const Color(0xFF191D28),
                  child: ListTile(
                    leading: const Icon(Icons.build, color: Colors.blue),
                    title: Text(r.model),
                    subtitle: Text('${r.problem}\n${r.name} • ${r.phone}'),
                  ),
                );
              },
            ),
    );
  }
}

class PricesPage extends StatelessWidget {
  const PricesPage({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      'Ekran çalyşmak',
      'Batareýa çalyşmak',
      'Zarýad soketi',
      'Arka gapak',
      'Kamera',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Bahalar')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: items.map((e) => Card(
          color: const Color(0xFF191D28),
          child: ListTile(
            leading: const Icon(Icons.payments, color: Colors.blue),
            title: Text(e),
            subtitle: const Text('Bahasy ussa bilen kesgitlenýär'),
          ),
        )).toList(),
      ),
    );
  }
}

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    const items = [
      'Telefon çeholy', 'Zarýadnik', 'USB kabel', 'Bluetooth nausnik',
      'Powerbank', 'Gorag aýnasy', 'Smart sagat', 'Kolonka',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Aksessuarlar')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF191D28),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shopping_bag_outlined, color: Colors.blue, size: 42),
              const SizedBox(height: 12),
              Text(items[i], textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 55)),
          SizedBox(height: 20),
          Center(child: Text('Müşderi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          SizedBox(height: 30),
          Card(child: ListTile(leading: Icon(Icons.person), title: Text('Ady üýtgetmek'))),
          Card(child: ListTile(leading: Icon(Icons.phone), title: Text('Telefon belgisi'))),
          Card(child: ListTile(leading: Icon(Icons.info), title: Text('Programma barada'))),
        ],
      ),
    );
  }
}
