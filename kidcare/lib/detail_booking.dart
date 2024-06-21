import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'confirm_booking.dart';

class BookingForm extends StatefulWidget {
  final String nama_pengasuh;
  final String foto_pengasuh;
  final String id_user;
  final String id_pengasuh;

  const BookingForm(
      {required this.nama_pengasuh,
      required this.foto_pengasuh,
      required this.id_user,
      required this.id_pengasuh});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String result = '';

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xFFFF7A8F),
        onPressed: () {
          Navigator.pop(context);
        },
      )),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Text(
                              'DETAIL BOOKING',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                color: Color(0xFFFF7A8F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              widget.nama_pengasuh,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 130,
                          height: 130,
                          child: ClipOval(
                            child: Image.network(
                              widget.foto_pengasuh,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 236, 239),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // TANGGAL
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 30.0, left: 20.0, bottom: 5.0, right: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFFFF7A8F),
                              size: 20.0,
                            ),
                            SizedBox(
                                width:
                                    8.0), // Menambahkan jarak antara ikon dan teks
                            Text(
                              'Pilih Tanggal',
                              style: TextStyle(
                                color: Color(0xFFFF7A8F),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              'Tanggal Mulai',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildDateField(_startDateController),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              'Tanggal Selesai',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildDateField(_endDateController),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              '*jika harinya sama maka, pilih tanggal yang sama',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // PUKUL
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 5.0, right: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time_filled_outlined,
                              color: Color(0xFFFF7A8F),
                              size: 20.0,
                            ),
                            SizedBox(
                                width:
                                    8.0), // Menambahkan jarak antara ikon dan teks
                            Text(
                              'Pilih Waktu',
                              style: TextStyle(
                                color: Color(0xFFFF7A8F),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              'Mulai Pukul',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildTimeField(_startTimeController),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              'Selesai Pukul',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildTimeField(_endTimeController),
                          ),
                        ],
                      ),

                      // ANAK
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, left: 20.0, bottom: 5.0, right: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.child_friendly_rounded,
                              color: Color(0xFFFF7A8F),
                              size: 20.0,
                            ),
                            SizedBox(
                                width:
                                    8.0), // Menambahkan jarak antara ikon dan teks
                            Text(
                              'Data Anak',
                              style: TextStyle(
                                color: Color(0xFFFF7A8F),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: Text(
                              'Nama Anak',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 5.0),
                            child: _buildTextField('', _nameController),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Usia Anak',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildTextField('', _ageController,
                                isNumber: true),
                          ),
                        ],
                      ),

                      // KEGIATAN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 20.0,
                                left: 20.0,
                                bottom: 5.0,
                                right: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.list_alt_rounded,
                                  color: Color(0xFFFF7A8F),
                                  size: 20.0,
                                ),
                                SizedBox(
                                    width:
                                        8.0), // Menambahkan jarak antara ikon dan teks
                                Text(
                                  'Kegiatan',
                                  style: TextStyle(
                                    color: Color(0xFFFF7A8F),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildTextField('', _activitiesController),
                          ),
                        ],
                      ),

                      // CATATAN
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, left: 20.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.note_alt_rounded,
                                  color: Color(0xFFFF7A8F),
                                  size: 20.0,
                                ),
                                SizedBox(
                                    width:
                                        8.0), // Menambahkan jarak antara ikon dan teks
                                Text(
                                  'Catatan',
                                  style: TextStyle(
                                    color: Color(0xFFFF7A8F),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: _buildTextField('', _notesController),
                          ),
                        ],
                      ),

                      // ALAMAT
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, left: 20.0, bottom: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFFFF7A8F),
                                  size: 20.0,
                                ),
                                SizedBox(
                                    width:
                                        8.0), // Menambahkan jarak antara ikon dan teks
                                Text(
                                  'Detail Alamat',
                                  style: TextStyle(
                                    color: Color(0xFFFF7A8F),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 80.0),
                            child: _buildTextField('', _addressController),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmBooking(
                        bookingData: {
                          'nama_pengasuh': widget.nama_pengasuh,
                          'tgl_mulai': _startDateController.text,
                          'tgl_selesai': _endDateController.text,
                          'waktu_mulai': _startTimeController.text,
                          'waktu_selesai': _endTimeController.text,
                          'daftar_kegiatan': _activitiesController.text,
                          'catatan': _notesController.text,
                          'patokan_rumah': _addressController.text,
                          'id_pengasuh': widget.id_pengasuh,
                          'id_user': widget.id_user,
                          'nama_anak': _nameController.text,
                          'umur_anak': _ageController.text,
                          'status': 'book',
                        },
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: const Color(0xFFFF7A8F),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'KONFIRMASI',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        prefixText: '',
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
      onTap: () => _selectDate(context, controller),
    );
  }

  Widget _buildTimeField(TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        prefixText: '',
        hintText: '',
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
      onTap: () => _selectTime(context, controller),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixText: '',
        hintText: label,
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
    );
  }
}
