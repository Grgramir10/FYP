import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/product.dart';
import 'package:ecom_2/app/modules/Favorites/views/favorites_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:ecom_2/app/views/views/about_us_view.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
        backgroundColor: Color(0xFFC4DBF6),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Color(0xFFC4DBF6),
                flexibleSpace: Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/LOGO.png',
                        height: 150,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: SearchView(),
                              // query: query,
                            );
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              onPressed: () {
                                showSearch(
                                  context: context,
                                  delegate: SearchView(),
                                  // query: query,
                                );
                              },
                              icon: const Icon(Icons.search),
                            ),
                          ),
                          onSubmitted: (query) {
                            // showSearch(
                            //   context: context,
                            //   delegate: SearchView(),
                            //   query: query,
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.PROFILE);
                      },
                      icon: Icon(Icons.person))
                ],
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                padding: const EdgeInsets.only(left: 99, bottom: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFE7E3D4),
                  image: DecorationImage(
                    image: AssetImage('assets/LOGO.png'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.money_off_csred_sharp,
                  color: Colors.black,
                ),
                title: Text('My Orders'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderView(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                title: Text('Favorites'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesView(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton2<Category>(
                        isExpanded: true,
                        hint: const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        items: controller.categories
                                ?.map((category) => DropdownMenuItem<Category>(
                                      value: category,
                                      child: Text(
                                        category.categoryTitle!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList() ??
                            [],
                        onChanged: (Category? selectedCategory) {
                          if (selectedCategory != null) {
                            print(
                                'Selected category: ${selectedCategory.categoryId}');
                            Get.toNamed(Routes.DETAIL_CATEGORY,
                                arguments: selectedCategory);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: Text('About Us'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsView(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text('Logout'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            MemoryManagement.removeAll();
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.categories == null) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue), // Change loading indicator color
                  strokeWidth: 2.0,
                ),
              );
            }

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.categories?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.DETAIL_CATEGORY,
                                    arguments: controller.categories?[index]);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF8590AA), // changed color
                                  borderRadius: BorderRadius.circular(
                                      10), // changed border radius
                                ),
                                child: Center(
                                  child: Text(
                                    controller
                                            .categories?[index].categoryTitle ??
                                        '',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.products == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.products?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) => SizedBox(
                                width: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: ProductCard(
                                    product: controller.products![index],
                                  ),
                                )),
                          )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

HomeController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> suggestions = [];
    suggestions = controller.products
            ?.where((element) =>
                element.title?.toLowerCase().contains(query.toLowerCase()) ??
                false)
            .toList() ??
        [];

    return ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) => SizedBox(
              height: 100,
              child: AdminProductCard(product: suggestions[index]),
            ));
  }
}
