import 'package:carousel_slider/carousel_slider.dart';
import 'package:edugate/core/app_functions.dart';
import 'package:edugate/core/cache_helper.dart';
import 'package:edugate/features/about_us/about_us_dialog.dart';
import 'package:edugate/features/applications/applications_screen.dart';
import 'package:edugate/features/ask/asks_screen.dart';
import 'package:edugate/features/contact_us/contact_us_dialog.dart';
import 'package:edugate/features/home/cubit/home_cubit.dart';
import 'package:edugate/features/profile/profile_screen.dart';
import 'package:edugate/features/saved_universities/saved_universities_screen.dart';
import 'package:edugate/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_colors.dart';
import '../university_details/university_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit.get(context).getUniversities();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is SavedFavouriteState) {
          context.showSuccessSnack("Saved to favourites");
        }
        if (state is RemovedFavouriteState) {
          context.showErrorSnack("Removed from favourites");
        }
      },
      builder: (context, state) {
        var universities = HomeCubit.get(context).universities;
        return Scaffold(
          appBar: AppBar(title: Text("EduGate")),
          endDrawer: Drawer(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.primary,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/icon.svg",
                          height: 50,
                          width: 50,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(
                          "EduGate",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Profile"),
                  onTap: () {
                    context.goToPage(ProfileScreen());
                  },
                  leading: Icon(Icons.person),
                ),
                ListTile(
                  title: Text("My Applications"),
                  onTap: () {
                    context.goToPage(ApplicationsScreen());
                  },
                  leading: Icon(Icons.pages),
                ),
                ListTile(
                  title: Text("Saved Universities"),
                  onTap: () {
                    context.goToPage(SavedUniversitiesScreen());
                  },
                  leading: Icon(Icons.bookmark),
                ),
                ListTile(
                  title: Text("Ask"),
                  onTap: () {
                    context.goToPage(AsksScreen());
                  },
                  leading: Icon(Icons.question_mark),
                ),
                ListTile(
                  title: Text("About us"),
                  onTap: () {
                    AboutUsDialog.show(context);
                  },
                  leading: Icon(Icons.info),
                ),
                ListTile(
                  title: Text("Contact us"),
                  onTap: () {
                    ContactUsDialog.show(context);
                  },
                  leading: Icon(Icons.contact_page),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Logout"),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.goOffAll(SplashScreen());
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
          body:
              state is LoadingHomeState
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          HomeCubit.get(context).adsUniversities.isEmpty
                              ? Center(child: Text("No ADS Found"))
                              : CarouselSlider.builder(
                                itemCount:
                                    HomeCubit.get(
                                      context,
                                    ).adsUniversities.length,
                                itemBuilder: (context, index, realIndex) {
                                  return InkWell(
                                    onTap: () {
                                      context.goToPage(
                                        UniversityDetailsScreen(
                                          item:
                                              HomeCubit.get(
                                                context,
                                              ).adsUniversities[index],
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: context.screenWidth,
                                          height:
                                              200, // You can adjust this height as needed
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                HomeCubit.get(
                                                  context,
                                                ).adsUniversities[index].image,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: context.screenWidth,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            color: Colors.black.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: 25,
                                          bottom: 25,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              HomeCubit.get(
                                                context,
                                              ).adsUniversities[index].name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  height: 100,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                ),
                              ),
                          SizedBox(height: 5),
                          SearchBar(
                            hintText: "Search for universities",
                            onChanged: (value) {
                              HomeCubit.get(context).search(value);
                            },
                            trailing: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.search),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          universities.isEmpty
                              ? Column(
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
                              )
                              : ListView.builder(
                                itemBuilder: (context, index) {
                                  var item = universities[index];
                                  var isFavourite = CacheHelper.isFavorite(
                                    item.id,
                                  );
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
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        item.name,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          HomeCubit.get(
                                                            context,
                                                          ).makeFavourite(item);
                                                        },
                                                        icon: Icon(
                                                          isFavourite
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_border,
                                                          color:
                                                              isFavourite
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    item.desc,
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    item.address,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    minWidth:
                                                        context.screenWidth,
                                                    height: 50,
                                                    color: AppColors.primary,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            4,
                                                          ),
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
      },
    );
  }
}
