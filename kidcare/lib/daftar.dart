import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kidcare/home.dart';
import 'package:kidcare/login.dart';


class DaftarPage extends StatefulWidget {
  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // bool _isLoading = false;

  // Future<void> _login() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     final authService = AuthService();
  //     final userId = await authService.login(
  //       _emailController.text,
  //       _passwordController.text,
  //     );
  //     // Simpan id_user ke SharedPreferences
  //     await _saveUserId(userId!);

  //     // Navigasi ke halaman utama atau lakukan tindakan lain setelah login berhasil
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => MyHomePage(userId: userId)),
  //     );
  //   } catch (e) {
  //     // Tampilkan pesan error saat login gagal
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Login failed: $e'),
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _saveUserId(int userId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('userId', userId);
  // }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250.0), // Set this height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30), // Adjust the radius as needed
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFFFF7A8F),
            flexibleSpace: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'DAFTAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'Modak',
                    ),
                  ),
                  Text(
                    'Masukkan data anda dengan sesuai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30.0, left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0), 
              child: Text(
                'Nama Lengkap',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0), 
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0), 
              child: Text(
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0), 
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0), 
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0), 
              child: Text(
                'Alamat',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0), 
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 20.0), 
              child: Text(
                'Telepon',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 188, 188, 188).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0), 
                    ),
                  ],
                ),
                child: TextField(
                  // controller: _emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // Hanya menerima angka
                  ],
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 188, 188, 188),
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0), 
              child: SizedBox(
                width: double.infinity, 
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()), 
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20), 
                    backgroundColor: const Color(0xFFFF7A8F), 
                    textStyle: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), 
                    ),
                  ),
                  child: const Text(
                    'Daftar', 
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ), 
                  ),
                ),

              ),
            ),

            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 197, 197, 197), 
                      width: 1.0, 
                    ),
                  ),
                ),
              ),        
            ),
            const SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      'Sudah Punya Akun?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),                
                  GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman lain
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        color: Color(0xFFFF7A8F), 
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,                      
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}


void main() {
  runApp(DaftarPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(      
    debugShowCheckedModeBanner: false,
      title: 'My App',
      home: DaftarPage(),
    );
  }
}