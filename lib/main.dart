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
        backgroundColor: const Color(0xFF0F1018),
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
              'Telefon meseläňiz üçin bir ýerde!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Esasy arza bölümi
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
                  const Icon(
                    Icons.build_circle_outlined,
                    size: 50,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'TELEFON BEJERTMEK',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Arzaňyzy aňsat we çalt iberiň!',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RepairRequestPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 13,
                      ),
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
              childAspectRatio: 1.35,
              children: [
                _menuButton(
                  context,
                  Icons.build,
                  'Telefon bejertmek',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RepairRequestPage(),
                      ),
                    );
                  },
                ),
                _menuButton(
                  context,
                  Icons.receipt_long,
                  'Arzalarym',
                  () {
                    _showMessage(context, 'Arzalarym bölümi ýakynda!');
                  },
                ),
                _menuButton(
                  context,
                  Icons.payments,
                  'Bahalar',
                  () {
                    _showMessage(context, 'Bahalar bölümi ýakynda!');
                  },
                ),
                _menuButton(
                  context,
                  Icons.shopping_cart_outlined,
                  'Aksessuarlar',
                  () {
                    _showMessage(
                      context,
                      'Aksessuarlar bölümi ýakynda!',
                    );
                  },
                ),
                _menuButton(
                  context,
                  Icons.phone,
                  'Habarlaşmak',
                  () {
                    _showMessage(
                      context,
                      'Habarlaşmak bölümi ýakynda!',
                    );
                  },
                ),
                _menuButton(
                  context,
                  Icons.location_on_outlined,
                  'Biziň salgymyz',
                  () {
                    _showMessage(
                      context,
                      'Salgymyz ýakynda goşular!',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

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
                color: const Color(0xFF181B26),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.blueAccent,
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.verified_user,
                    color: Colors.blueAccent,
                    size: 35,
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Ynamly hyzmat we professional telefon bejergisi.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF15161E),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Baş sahypa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Arzalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Arza',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: 'Bahalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  static Widget _menuButton(
    BuildContext context,
    IconData icon,
    String text,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
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
              text,
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

  static Widget _step(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: Colors.blue,
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

  static void _showMessage(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}


// ======================================================
// TELEFON BEJERTMEK — ARZA FORMASY
// ======================================================

class RepairRequestPage extends StatefulWidget {
  const RepairRequestPage({super.key});

  @override
  State<RepairRequestPage> createState() =>
      _RepairRequestPageState();
}

class _RepairRequestPageState
    extends State<RepairRequestPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController modelController =
      TextEditingController();

  final TextEditingController problemController =
      TextEditingController();

  final TextEditingController noteController =
      TextEditingController();

  String selectedProblem = 'Ekran döwüldi';

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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Arza kabul edildi! ✅'),
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
        key: _formKey,
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
                'Aşakdaky maglumatlary dolduryň.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 22),

              _label('Adyňyz'),

              TextFormField(
                controller: nameController,
                decoration: _decoration(
                  'Adyňyzy ýazyň',
                  Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Adyňyzy ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              _label('Telefon belgiňiz'),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: _decoration(
                  'Telefon belgiňiz',
                  Icons.phone_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefon belgiňizi ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              _label('Telefon modeli'),

              TextFormField(
                controller: modelController,
                decoration: _decoration(
                  'Meselem: iPhone 13 Pro',
                  Icons.smartphone_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Telefon modelini ýazyň';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              _label('Näsazlyk'),

              DropdownButtonFormField<String>(
                initialValue: selectedProblem,
                decoration: _decoration(
                  'Näsazlygy saýlaň',
                  Icons.build_outlined,
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
                      selectedProblem = value;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              _label('Näsazlygyň düşündirişi'),

              TextFormField(
                controller: problemController,
                maxLines: 4,
                decoration: _decoration(
                  'Telefonda näme problema bar?',
                  Icons.description_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Problema barada ýazmagyňyzy haýyş edýäris';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              _label('Goşmaça bellik'),

              TextFormField(
                controller: noteController,
                maxLines: 3,
                decoration: _decoration(
                  'Goşmaça maglumat bar bolsa ýazyň',
                  Icons.note_alt_outlined,
                ),
              ),

              const SizedBox(height: 22),

              // Surat goşmak bölümi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF181B26),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.photo_camera_outlined,
                      size: 45,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Telefonuň suratyny goş',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Bu funksiýany indiki ädimde goşarys.',
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

  Widget _label(String text) {
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

  InputDecoration _decoration(
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
          color: Col
