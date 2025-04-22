import 'package:edugate/core/app_colors.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:edugate/features/apply_for_university/apply_for_university_screen.dart';
import 'package:edugate/features/home/models/university_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UniversityDetailsScreen extends StatelessWidget {
  const UniversityDetailsScreen({super.key, required this.item});

  final UniversityModel item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item.image,
              height: 300,
              fit: BoxFit.cover,
              width: context.screenWidth,
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.mail),
                      title: Text(
                        item.email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.phone),
                      title: Text(
                        item.phone,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.location_pin),
                      title: Text(item.address, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () async {
                        final Uri url = Uri.parse(item.website);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      leading: Icon(Icons.link),
                      title: Text(item.website, style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  Text("Requirements"),
                  Text(item.requirements, style: TextStyle(fontSize: 16)),

                  Divider(),
                  Text("Majors", style: TextStyle(fontWeight: FontWeight.bold)),

                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary,
                          ),
                          child: Text(
                            item.majors[index].name,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                      itemCount: item.majors.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),

                  Text(item.desc, style: TextStyle(fontSize: 16)),

                  MaterialButton(
                    onPressed: () {
                      context.goToPage(ApplyForUniversityScreen(item: item));
                    },
                    minWidth: context.screenWidth,
                    height: 50,
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Apply Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
