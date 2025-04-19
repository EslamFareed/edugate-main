import 'package:edugate/core/app_functions.dart';
import 'package:edugate/core/cache_helper.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../university_details/university_details_screen.dart';

class SavedUniversitiesScreen extends StatelessWidget {
  const SavedUniversitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var universities = CacheHelper.getFavorite();
    return Scaffold(
      appBar: AppBar(title: Text("Saved Universities")),
      body:
          universities.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      size: 100,
                      color: AppColors.primary,
                    ),
                    Text(
                      "No Universities Found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemBuilder: (context, index) {
                          var item = universities[index];

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
                                        image: NetworkImage(item.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item.desc,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            item.address,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          MaterialButton(
                                            onPressed: () {
                                              context.goToPage(
                                                UniversityDetailsScreen(
                                                  item: item,
                                                ),
                                              );
                                            },
                                            minWidth: context.screenWidth,
                                            height: 50,
                                            color: AppColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              "View All Details",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: universities.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
