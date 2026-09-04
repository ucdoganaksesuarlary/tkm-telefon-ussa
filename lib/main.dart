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
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openRepair(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RepairPage(),
      ),
    );
  }

  void message(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
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
        decoration: BoxDecoration(
          color: const Color(0xFF181B26),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget step(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 17,
            child: Text(
              '$number',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
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
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
            ),
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF087CFF),
                    Color(0xFF0643A5),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.build_circle,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'TELEFON BEJERTMEK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Arzaňyzy aňsat we çalt iberiň!',
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () => openRepair(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Arza ber →',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Hyzmatlar',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                serviceButton(
                  context,
                  Icons.build,
                  'Telefon bejertmek',
                  () => openRepair(context),
                ),
                serviceButton(
                  context,
                  Icons.receipt_long,
                  'Arzalarym',
                  () => message(
                    context,
                    'Arzalarym ýakynda goşular.',
                  ),
                ),
                serviceButton(
                  context,
                  Icons.payments,
                  'Bahalar',
                  () => message(
                    context,
                    'Bahalar ýakynda goşular.',
                  ),
                ),
                serviceButton(
                  context,
                  Icons.shopping_cart,
                  'Aksessuarlar',
                  () => message(
                    context,
                    'Aksessuarlar ýakynda goşular.',
                  ),
                ),
                serviceButton(
                  context,
                  Icons.phone,
                  'Habarlaşmak',
                  () => message(
                    context,
                    'Habarlaşmak bölümi ýakynda goşular.',
                  ),
                ),
                serviceButton(
                  context,
                  Icons.location_on,
                  'Biziň salgymyz',
                  () => message(
                    context,
                    'Salgy ýakynda goşular.',
                  ),
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

            step(1, 'Maglumatlary doldur'),
            step(2, 'Telefon meseläňizi ýaz'),
            step(3, 'Arzany iber'),
            step(4, 'Biz habar bereris'),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF181B26),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.blue,
                    size: 35,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Ynamly hyzmat we professional telefon bejergisi.',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),

      // Bu ýerde const aýryldy
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF15161E),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Baş sahypa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Arzalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Arza',
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
}


// =====================================================
// TELEFON BEJERTMEK — ARZA FORMASY
// =====================================================

class RepairPage extends StatefulWidget {
  const RepairPage({super.key});

  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final modelController = TextEditingController();
  final problemController = TextEditingController();
  final noteController = TextEditingController();

  String problem = 'Ekran döwüldi';

  final List<String> problems = [
    'Ekran döwüldi',
    'Sensor işlemeýär',
    'Zarýad almaýar',
    'Telefon açylmaýar',
    'Batareýa meselesi',
    'Kamera işlemeýär',
    'Ses meselesi',
    'Başga mesele',
  ];

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    modelController.dispose();
    problemController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void sendRequest() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Arza kabul edildi! ✅',
          ),
          content: const Text(
            'Arzaňyz üstünlikli taýýarlandy. '
            'Ussa ýakyn wagtda siziň bilen habarlaşar.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Bolýar'),
            ),
          ],
        );
      },
    );
  }

  InputDecoration input(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFF181B26),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF292D3A),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
    );
  }

  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Telefon bejertmek',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0F1018),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Telefon barada maglumat',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Maglumatlary dolduryp arzany iberiň.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 22),

              label('Adyňyz'),

              TextFormField(
                controller: nameController,
                decoration: input(
                  'Adyňyzy ýazyň',
                  Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Adyňyzy ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              label('Telefon belgiňiz'),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: input(
                  'Telefon belgiňiz',
                  Icons.phone_outlined,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Telefon belgiňizi ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              label('Telefon modeli'),

              TextFormField(
                controller: modelController,
                decoration: input(
                  'Meselem: iPhone 13 Pro',
                  Icons.smartphone,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Telefon modelini ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              label('Näsazlyk'),

              DropdownButtonFormField<String>(
                value: problem,
                decoration: input(
                  'Näsazlygy saýlaň',
                  Icons.build_outlined,
                ),
                items: problems.map((item) {
                  return DropdownMenuItem<String>(
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

              const SizedBox(height: 16),

              label('Problema barada düşündiriş'),

              TextFormField(
                controller: problemController,
                maxLines: 4,
                decoration: input(
                  'Telefonda näme problema bar?',
                  Icons.description_outlined,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Problema barada ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              label('Goşmaça bellik'),

              TextFormField(
                controller: noteController,
                maxLines: 3,
                decoration: input(
                  'Goşmaça maglumat',
                  Icons.note_alt_outlined,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF181B26),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.blue,
                      size: 45,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '📷 Telefonuň suratyny goş',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Surat goşmak funksiýasyny '
                      'indiki ädimde goşarys.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: sendRequest,
                  icon: const Icon(Icons.send),
                  label: const Text(
                    'ARZANY IBER',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
