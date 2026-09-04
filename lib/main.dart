import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const TkmTelefonUssa());
}

class RepairRequest {
  final String name;
  final String phone;
  final String model;
  final String problem;
  final String details;
  final String? imagePath;

  RepairRequest({
    required this.name,
    required this.phone,
    required this.model,
    required this.problem,
    required this.details,
    this.imagePath,
  });
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<RepairRequest> requests = [];

  void openRepair() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RepairPage(
          onSubmit: (request) {
            setState(() {
              requests.add(request);
            });
          },
        ),
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
            requests.add(request);
          });
        },
      ),
      const PricesPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[currentIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Baş sahypa',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.list_alt),
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
              const Text(
                'TKM TELEFON USSA',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Häzirlikçe täze bildiriş ýok.'),
                    ),
                  );
                },
                icon: const Icon(Icons.notifications_none, size: 30),
              ),
            ],
          ),
          const SizedBox(height: 35),
          const Text(
            'Telefon meseläňiz üçin bir\nýerde!',
            style: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 35),
          InkWell(
            onTap: onRepair,
            borderRadius: BorderRadius.circular(28),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1688FF),
                    Color(0xFF0759D6),
                  ],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.build,
                      color: Colors.blue,
                      size: 38,
                    ),
                  ),
                  const SizedBox(height: 28),
                  const Text(
                    'TELEFON BEJERTMEK',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Arzaňyzy aňsat we çalt iberiň!',
                    style: TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Arza ber →',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Text(
            'Hyzmatlar',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1.05,
            children: [
              ServiceCard(
                icon: Icons.build,
                title: 'Telefon bejertmek',
                onTap: onRepair,
              ),
              ServiceCard(
                icon: Icons.list_alt,
                title: 'Arzalarym',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EmptyInfoPage(
                        title: 'Arzalarym',
                        text: 'Arzalaryňyzy aşakdaky "Arzalar" bölüminden görüp bilersiňiz.',
                      ),
                    ),
                  );
                },
              ),
              ServiceCard(
                icon: Icons.payments,
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
                icon: Icons.shopping_cart,
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

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF191D28),
          borderRadius: BorderRadius.circular(25),
        ),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RepairPage extends StatefulWidget {
  final Function(RepairRequest) onSubmit;

  const RepairPage({super.key, required this.onSubmit});

  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final modelController = TextEditingController();
  final problemController = TextEditingController();
  final detailsController = TextEditingController();

  String selectedProblem = 'Ekran döwüldi';
  File? selectedImage;

  final picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  void submit() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty ||
        problemController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Haýyş, gerekli maglumatlary dolduryň.'),
        ),
      );
      return;
    }

    final request = RepairRequest(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      model: modelController.text.trim(),
      problem: selectedProblem,
      details: problemController.text.trim(),
      imagePath: selectedImage?.path,
    );

    widget.onSubmit(request);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Arzaňyz üstünlikli iberildi!'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    modelController.dispose();
    problemController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefon bejertmek',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Telefon barada maglumat',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Maglumatlary dolduryp arzaňyzy iberiň.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 28),
            inputField(
              'Adyňyz',
              'Adyňyzy ýazyň',
              Icons.person_outline,
              nameController,
            ),
            inputField(
              'Telefon belgiňiz',
              'Telefon belgiňiz',
              Icons.phone,
              phoneController,
              keyboard: TextInputType.phone,
            ),
            inputField(
              'Telefon modeli',
              'Meselem: iPhone 13 Pro',
              Icons.phone_android,
              modelController,
            ),
            const SizedBox(height: 8),
            const Text(
              'Näsazlyk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedProblem,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.build),
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
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
              ]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedProblem = value;
                  });
                }
              },
            ),
            const SizedBox(height: 25),
            const Text(
              'Problema barada düşündiriş',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: problemController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Telefonda näme problema bar?',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 75),
                  child: Icon(Icons.description_outlined),
                ),
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Goşmaça maglumat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailsController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Goşmaça maglumat',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 55),
                  child: Icon(Icons.note_alt_outlined),
                ),
                filled: true,
                fillColor: const Color(0xFF191D28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: pickImage,
              borderRadius: BorderRadius.circular(22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFF191D28),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    if (selectedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          selectedImage!,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      const Icon(
                        Icons.add_a_photo,
                        color: Colors.blue,
                        size: 55,
                      ),
                    const SizedBox(height: 15),
                    Text(
                      selectedImage == null
                          ? '📷 Telefonyň suratyny goş'
                          : 'Surat saýlandy ✓',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Galereýadan telefon suratyny saýlaň.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 62,
              child: FilledButton.icon(
                onPressed: submit,
                icon: const Icon(Icons.send),
                label: const Text(
                  'ARZANY IBER',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget inputField(
    String label,
    String hint,
    IconData icon,
    TextEditingController controller, {
    TextInputType? keyboard,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 9),
          TextField(
            controller: controller,
            keyboardType: keyboard,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(icon),
              filled: true,
              fillColor: const Color(0xFF191D28),
              border: OutlineInputBorder(
                borderRadius: Borde
