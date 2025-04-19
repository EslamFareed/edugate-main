import 'package:edugate/core/app_functions.dart';
import 'package:edugate/features/applications/cubit/my_applications_cubit.dart';
import 'package:edugate/features/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyApplicationsCubit.get(
      context,
    ).getApplications(LoginCubit.get(context).userData["uid"]);
    return Scaffold(
      appBar: AppBar(title: Text("My Applications")),
      body: BlocBuilder<MyApplicationsCubit, MyApplicationsState>(
        builder: (context, state) {
          if (state is LoadingMyApplicationsState) {
            return Center(child: CircularProgressIndicator());
          }
          return MyApplicationsCubit.get(context).applications.isEmpty
              ? Center(child: Text("You have no applications"))
              : ListView.builder(
                itemCount: MyApplicationsCubit.get(context).applications.length,
                itemBuilder: (context, index) {
                  final item =
                      MyApplicationsCubit.get(context).applications[index];
                  return SizedBox(
                    height: 300,
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            width: context.screenWidth * .3,
                            height: 300,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(item.university.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.university.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Selected Major : ${item.major.name}"),
                                  Text(
                                    "Application Date : ${item.date.year}-${item.date.month}-${item.date.day}",
                                  ),
                                  SizedBox(height: 10),
                                  // if status is rejected text color red, if accepted green, if pending black, if interview blue
                                  Text(
                                    "Status : ${item.status}",
                                    style: TextStyle(
                                      color:
                                          item.status == "rejected"
                                              ? Colors.red
                                              : item.status == "accepted"
                                              ? Colors.green
                                              : item.status == "interview"
                                              ? Colors.blue
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text("Fees : ${item.major.fees}"),

                                  if (item.status == "interview")
                                    Text(
                                      "You have interview on ${item.interviewDate}",
                                    ),
                                  if (item.status == "interview")
                                    Text(
                                      "Interview Description : ${item.interviewDesc}",
                                    ),

                                  // if (item.status != "rejected")
                                  //   MaterialButton(
                                  //     onPressed: () {
                                  //       // context.goToPage(
                                  //       //   UniversityDetailsScreen(item: item),
                                  //       // );
                                  //     },
                                  //     minWidth: context.screenWidth,
                                  //     height: 50,
                                  //     color: AppColors.primary,
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(4),
                                  //     ),
                                  //     child: Text(
                                  //       "No Action",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
        },
      ),
    );
  }
}
