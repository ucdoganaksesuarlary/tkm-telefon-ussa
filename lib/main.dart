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
        scaffoldBackgroundColor: const Color(0xFF0F1018),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    RequestsPage(),
    RepairPage(),
    PricesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF171A24),
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

// ================= BAŞ SAHYPA =================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Widget serviceButton(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback action,
  ) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFF181C27),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blue, size: 38),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1018),
        title: const Text(
          'TKM TELEFON USSA',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Häzirlikçe täze bildiriş ýok.'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Telefon meseläňiz üçin bir ýerde!',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),

            // ARZA BER CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF087BFF),
                    Color(0xFF0755C9),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
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
                      size: 42,
                    ),
                  ),
                  const SizedBox(height: 25),
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
                  const SizedBox(height: 22),
                  ElevatedButton(
                    onPressed: () => openPage(
                      context,
                      const RepairPage(),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                    ),
                    child: const Text(
                      'Arza ber →',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Hyzmatlar',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                serviceButton(
                  context,
                  Icons.build,
                  'Telefon bejertmek',
                  () => openPage(
                    context,
                    const RepairPage(),
                  ),
                ),
                serviceButton(
                  context,
                  Icons.list_alt,
                  'Arzalarym',
                  () => openPage(
                    context,
                    const RequestsPage(),
                  ),
                ),
                serviceButton(
                  context,
                  Icons.payments,
                  'Bahalar',
                  () => openPage(
                    context,
                    const PricesPage(),
                  ),
                ),
                serviceButton(
                  context,
                  Icons.shopping_cart,
                  'Aksessuarlar',
                  () => openPage(
                    context,
                    const AccessoriesPage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================= ARZA FORMASY =================

class RepairPage extends StatefulWidget {
  const RepairPage({super.key});

  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final modelController = TextEditingController();
  final problemController = TextEditingController();

  String problemType = 'Ekran döwüldi';

  final problems = [
    'Ekran döwüldi',
    'Sensor işlemeýär',
    'Zaryad almaýar',
    'Açylmaýar',
    'Batareýa çalt gutarýar',
    'Kamera işlemeýär',
    'Ses işlemeýär',
    'Başga näsazlyk',
  ];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    modelController.dispose();
    problemController.dispose();
    super.dispose();
  }

  void sendRequest() {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Adyňyzy, telefon belgiňizi we telefon modelini ýazyň.',
          ),
        ),
      );
      return;
    }

    RepairStorage.requests.add(
      RepairRequest(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        model: modelController.text.trim(),
        problemType: problemType,
        description: problemController.text.trim(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Arzaňyz üstünlikli iberildi! ✅'),
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration decoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFF181C27),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
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
        padding: const EdgeInsets.all(18),
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
              'Maglumatlary dolduryp arzaňy iberiň.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              'Adyňyz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: decoration(
                'Adyňyzy ýazyň',
                Icons.person,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Telefon belgiňiz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: decoration(
                'Telefon belgiňiz',
                Icons.phone,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Telefon modeli',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: modelController,
              decoration: decoration(
                'Meselem: iPhone 13 Pro',
                Icons.phone_android,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Näsazlyk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: problemType,
              decoration: decoration(
                '',
                Icons.build,
              ),
              items: problems.map((problem) {
                return DropdownMenuItem(
                  value: problem,
                  child: Text(problem),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    problemType = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),
            const Text(
              'Problema barada düşündiriş',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: problemController,
              maxLines: 5,
              decoration: decoration(
                'Telefonda näme problema bar?',
                Icons.description,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: sendRequest,
                icon: const Icon(Icons.send),
                label: const Text(
                  'ARZANY IBER',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ================= ARZALARYM =================

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    final requests = RepairStorage.requests;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Arzalarym',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: requests.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 70,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Häzirlikçe arzaňyz ýok.',
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];

                return Card(
                  color: const Color(0xFF181C27),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.model,
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text('Näsazlyk: ${request.problemType}'),
                        Text('Telefon: ${request.phone}'),
                        if (request.description.isNotEmpty)
                          Text(
                            'Düşündiriş: ${request.description}',
                          ),
                        const SizedBox(height: 10),
                        const Chip(
                          label: Text('Garaşylýar'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ================= BAHALAR =================

class PricesPage extends StatelessWidget {
  const PricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prices = [
      ['iPhone ekran çalyşmak', 'Bahasy kesgitlenýär'],
      ['Samsung ekran çalyşmak', 'Bahasy kesgitlenýär'],
      ['Redmi ekran çalyşmak', 'Bahasy kesgitlenýär'],
      ['Zaryad nokady', 'Bahasy kesgitlenýär'],
      ['Batareýa çalyşmak', 'Bahasy kesgitlenýär'],
      ['Programma üpjünçiligi', 'Bahasy kesgitlenýär'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bahalar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: prices.length,
        itemBuilder: (context, index) {
          return Card(
            color: const Color(0xFF181C27),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.payments),
              ),
              title: Text(
                prices[index][0],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                prices[index][1],
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= AKSESSUARLAR =================

class AccessoriesPage extends StatelessWidget {
  const AccessoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accessories = [
      ['Zaryatnik', Icons.bolt],
      ['USB kabel', Icons.cable],
      ['Telefon çeholy', Icons.phone_android],
      ['Gorag aýnasy', Icons.shield],
      ['Bluetooth naushnik', Icons.headphones],
      ['Powerbank', Icons.battery_charging_full],
      ['Smart Watch', Icons.watch],
      ['Kolonka', Icons.speaker],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aksessuarlar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: accessories.length,
        it
