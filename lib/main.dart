import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const TkmTelefonUssa());
}

// ==================== MODEL ====================

class RepairRequest {
  final String name;
  final String phone;
  final String model;
  final String problem;
  final String details;
  final String? photo;
  final DateTime date;

  RepairRequest({
    required this.name,
    required this.phone,
    required this.model,
    required this.problem,
    required this.details,
    this.photo,
    required this.date,
  });
}

// ==================== APP ====================

class TkmTelefonUssa extends StatelessWidget {
  const TkmTelefonUssa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TKM TELEFON USSA',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0F15),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

// ==================== HOME ====================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<RepairRequest> requests = [];

  void openRepair() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RepairPage(
          onSubmit: (request) {
            setState(() {
              requests.insert(0, request);
            });
          },
        ),
      ),
    );
  }

  void showInfo(String title, String text) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ýap'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeContent(onRepair: openRepair),
      RequestsPage(requests: requests),
      RepairPage(
        onSubmit: (request) {
          setState(() {
            requests.insert(0, request);
            selectedIndex = 1;
          });
        },
      ),
      const PricesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        height: 72,
        backgroundColor: const Color(0xFF181B24),
        indicatorColor: Colors.blue.withOpacity(0.22),
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Baş sahypa',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Arzalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Arza',
          ),
          NavigationDestination(
            icon: Icon(Icons.payments_outlined),
            selectedIcon: Icon(Icons.payments),
            label: 'Bahalar',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ==================== HOME CONTENT ====================

class HomeContent extends StatelessWidget {
  final VoidCallback onRepair;

  const HomeContent({
    super.key,
    required this.onRepair,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TKM TELEFON USSA',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Professional telefon hyzmatlary',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181B24),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Täze bildiriş ýok.'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_none),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Telefon meseläňiz üçin bir ýerde!',
                style: TextStyle(
                  fontSize: 28,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade100,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
            sliver: SliverToBoxAdapter(
              child: GestureDetector(
                onTap: onRepair,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1688FF),
                        Color(0xFF0756C9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.build_rounded,
                          color: Colors.blue,
                          size: 31,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'TELEFON BEJERTMEK',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Arzaňyzy aňsat we çalt iberiň!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 13,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Arza ber',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                              size: 19,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Hyzmatlar',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.grey.shade100,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate([
                ServiceCard(
                  icon: Icons.build_rounded,
                  title: 'Telefon bejertmek',
                  onTap: onRepair,
                ),
                ServiceCard(
                  icon: Icons.receipt_long_rounded,
                  title: 'Arzalarym',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmptyRequestsPage(),
                      ),
                    );
                  },
                ),
                ServiceCard(
                  icon: Icons.payments_rounded,
                  title: 'Bahalar',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PricesPage(),
                      ),
                    );
                  },
                ),
                ServiceCard(
                  icon: Icons.shopping_cart_rounded,
                  title: 'Aksessuarlar',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AccessoriesPage(),
                      ),
                    );
                  },
                ),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.95,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF181B24),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '7/24 hyzmatda',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Soraglaryňyz we arzaňyz üçin elmydama habarlaşyp bilersiňiz.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== SERVICE CARD ====================

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF181B24),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.blue,
                size: 45,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== REPAIR PAGE ====================

class RepairPage extends StatefulWidget {
  final Function(RepairRequest) onSubmit;

  const RepairPage({
    super.key,
    required this.onSubmit,
  });

  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final modelController = TextEditingController();
  final detailsController = TextEditingController();

  String problem = 'Ekran döwüldi';
  String? imagePath;

  final ImagePicker picker = ImagePicker();

  final problems = [
    'Ekran döwüldi',
    'Sensor işlemeýär',
    'Batareýa çalt gutarýar',
    'Zarýad almaýar',
    'Kamera işlemeýär',
    'Ses işlemeýär',
    'Telefon açylmaýar',
    'Wi-Fi / Internet meselesi',
    'Başga näsazlyk',
  ];

  Future<void> pickPhoto() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  void submit() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Adyňyzy, telefon belgiňizi we telefon modelini giriziň.',
          ),
        ),
      );
      return;
    }

    final request = RepairRequest(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      model: modelController.text.trim(),
      problem: problem,
      details: detailsController.text.trim(),
      photo: imagePath,
      date: DateTime.now(),
    );

    widget.onSubmit(request);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 55,
        ),
        title: const Text('Arzaňyz kabul edildi'),
        content: const Text(
          'Sag boluň! Arzaňyz üstünlikli iberildi. '
          'Hünärmen siziň bilen habarlaşar.',
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Bolýar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    modelController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefon bejertmek',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Näsazlyk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: problem,
              decoration: inputDecoration('Näsazlygy saýlaň'),
              items: problems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    problem = value;
                  });
                }
              },
            ),

            const SizedBox(height: 22),

            const Text(
              'Müşderi maglumatlary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: nameController,
              decoration: inputDecoration('Adyňyz'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: inputDecoration('Telefon belgiňiz'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: modelController,
              decoration: inputDecoration(
                'Telefon modeli',
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Meseläni düşündiriň',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: detailsController,
  
