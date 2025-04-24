import 'package:edugate/core/app_functions.dart';
import 'package:edugate/features/apply_for_university/cubit/apply_cubit.dart';
import 'package:edugate/features/home/models/major_model.dart';

import 'package:edugate/features/home/models/university_model.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_colors.dart';

class ApplyForUniversityScreen extends StatelessWidget {
  ApplyForUniversityScreen({super.key, required this.item});
  final UniversityModel item;

  final idNumberController = TextEditingController();
  final highSchoolNameController = TextEditingController();
  final highSchoolPercentageController = TextEditingController();
  final fatherPhoneController = TextEditingController();
  final fatherJobController = TextEditingController();
  final motherJobController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherPhoneController = TextEditingController();

  // final dateOfBirthController = TextEditingController();

  // String? gender;
  Major? selectedMajor;
  String? selectedType;

  final _formKey = GlobalKey<FormState>();

  // void _selectDate(context) async {
  //   DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null) {
  //     dateOfBirthController.text =
  //         "${picked.day.toString().padLeft(2, '0')}/"
  //         "${picked.month.toString().padLeft(2, '0')}/"
  //         "${picked.year}";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ApplyCubit.get(context).idPhoto = null;
    ApplyCubit.get(context).certificatePhoto = null;
    return Scaffold(
      appBar: AppBar(title: Text("Apply for ${item.name}")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                //! ------------------- Major ------------------!
                Row(children: [Text("Major *")]),
                SizedBox(height: 5),
                DropdownButtonFormField<Major>(
                  value: selectedMajor,
                  hint: Text("Select Major"),
                  selectedItemBuilder: (context) {
                    return item.majors.map((m) {
                      return Text(m.name);
                    }).toList();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items:
                      item.majors.map((m) {
                        return DropdownMenuItem<Major>(
                          value: m,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${m.name}\nPercentage : ${m.score}\nfees : ${m.fees}",
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    selectedMajor = value;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Major is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Application Type ------------------!
                Row(children: [Text("Application Type *")]),
                SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  value: selectedType,
                  hint: Text("Select Application Type"),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items:
                      ["New Student", "Transfer Student"].map((m) {
                        return DropdownMenuItem<String>(
                          value: m,
                          child: Text(m),
                        );
                      }).toList(),
                  onChanged: (value) {
                    selectedType = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Application Type is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- ID Number ------------------!
                Row(children: [Text("ID Number *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: idNumberController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLength: 14,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "ID Number is required";
                    }
                    if (value.length != 14) {
                      return "ID Number must be 14 digits";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- High School Name ------------------!
                Row(children: [Text("High School Name *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: highSchoolNameController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "High School Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- High School Percentage ------------------!
                Row(children: [Text("High School Percentage Without % *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: highSchoolPercentageController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "High School Percentage is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Father Phone ------------------!
                Row(children: [Text("Father Phone *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: fatherPhoneController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Father Phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Father Job ------------------!
                Row(children: [Text("Father Job *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: fatherJobController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Father Job is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Mother Name ------------------!
                Row(children: [Text("Mother Name *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: motherNameController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mother Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Mother Phone ------------------!
                Row(children: [Text("Mother Phone *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: motherPhoneController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mother Phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- Mother Job ------------------!
                Row(children: [Text("Mother Job *")]),
                SizedBox(height: 5),
                TextFormField(
                  controller: motherJobController,
                  decoration: InputDecoration(
                    hintText: "",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mother Job is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- ID Photo ------------------!
                Row(children: [Text("ID Photo *")]),
                SizedBox(height: 5),
                BlocBuilder<ApplyCubit, ApplyState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        ApplyCubit.get(context).selectIDPhoto();
                      },
                      child: Container(
                        width: context.screenWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:
                              state is LoadingUploadIDState
                                  ? CircularProgressIndicator()
                                  : ApplyCubit.get(context).idPhoto == null
                                  ? Icon(Icons.upload)
                                  : Image.network(
                                    ApplyCubit.get(context).idPhoto ?? "",
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: context.screenWidth,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),

                // //! ------------------- High School Certificate Photo ------------------!
                Row(children: [Text("High School Certificate Photo *")]),
                SizedBox(height: 5),
                BlocBuilder<ApplyCubit, ApplyState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        ApplyCubit.get(context).selectCertificatePhoto();
                      },
                      child: Container(
                        width: context.screenWidth,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:
                              state is LoadingUploadCertificateState
                                  ? CircularProgressIndicator()
                                  : ApplyCubit.get(context).certificatePhoto ==
                                      null
                                  ? Icon(Icons.upload)
                                  : Image.network(
                                    ApplyCubit.get(context).certificatePhoto ??
                                        "",
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: context.screenWidth,
                                  ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),

                //! ------------------- Sign Up Button ------------------!
                BlocConsumer<ApplyCubit, ApplyState>(
                  listener: (context, state) {
                    if (state is SuccessApplyState) {
                      context.showSuccessSnack("Application Sent Successfully");
                      Navigator.pop(context);
                    }
                    if (state is ErrorApplyState) {
                      context.showErrorSnack(
                        "Something went wrong, or You have applied with same major before please change the major or try again",
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is LoadingApplyState
                        ? Center(child: CircularProgressIndicator())
                        : MaterialButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                ApplyCubit.get(context).idPhoto != null &&
                                ApplyCubit.get(context).certificatePhoto !=
                                    null) {
                              ApplyCubit.get(context).apply(
                                university: item,
                                user: LoginCubit.get(context).userData,
                                majorSelected: selectedMajor!,
                                typeSelected: selectedType!,
                                idNumber: idNumberController.text,
                                highSchoolName: highSchoolNameController.text,
                                highSchoolPercentage:
                                    highSchoolPercentageController.text,
                                fatherPhone: fatherPhoneController.text,
                                fatherJob: fatherJobController.text,
                                motherName: motherNameController.text,
                                motherPhone: motherPhoneController.text,
                                motherJob: motherJobController.text,
                              );
                            } else {
                              context.showErrorSnack(
                                "Please enter all data, choose id photo and certificate photo",
                              );
                            }
                          },
                          minWidth: context.screenWidth,
                          height: 50,
                          color: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "Apply NOW",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
