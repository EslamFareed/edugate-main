import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController nationalityController;
  late TextEditingController dobController;

  String gender = 'Male';

  @override
  void initState() {
    super.initState();
    final data = widget.userData;
    nameController = TextEditingController(text: data["name"]);
    phoneController = TextEditingController(text: data["phone"]);
    nationalityController = TextEditingController(text: data["nationality"]);
    dobController = TextEditingController(text: data["dateOfBirth"]);
    gender = data["gender"];
  }

  void saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    final updatedData = {
      "name": nameController.text.trim(),
      "phone": phoneController.text.trim(),
      "gender": gender,
      "nationality": nationalityController.text.trim(),
      "dateOfBirth": dobController.text.trim(),
      "email": widget.userData["email"],
    };

    LoginCubit.get(context).editProfile(updatedData);
  }

  Future<void> _selectDate() async {
    DateTime initialDate = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      dobController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  width: context.screenWidth,
                  height: 250,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.userData["email"],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField("Name", nameController),
                        _buildTextField(
                          "Phone",
                          phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        _buildDropdownField("Gender"),
                        _buildTextField("Nationality", nationalityController),
                        _buildDateField("Date of Birth", dobController),
                        const SizedBox(height: 20),
                        state is LoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (val) => val!.trim().isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: gender,
        decoration: const InputDecoration(
          labelText: "Gender",
          border: OutlineInputBorder(),
        ),
        items: const [
          DropdownMenuItem(value: "Male", child: Text("Male")),
          DropdownMenuItem(value: "Female", child: Text("Female")),
        ],
        onChanged: (val) {
          setState(() => gender = val!);
        },
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: _selectDate,
        validator: (val) => val!.trim().isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
      ),
    );
  }
}
