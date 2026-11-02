import 'package:carousel_slider/carousel_slider.dart';
import 'package:depi_five/features/home/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../cubit/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeBannersErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load banners')),
                  );
                } else if (state is HomeBannersSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Banners loaded successfully'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                if (state is HomeBannersLoadingState) {
                  return const Center(
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                }
               
                return CarouselSlider(
                  items: [
                    for (var banner in cubit.bannerModel.data ?? [])
                      Container(
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage(banner.image ?? ''),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                  ],
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                );
              },
            ),
            Row(
              children: [
                Text(
                  'Popular Pack',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Handle "See All" button press
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ],
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is HomeProductsErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to load products')),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();
                List<Products>? products = cubit.productModel.data?.products;
                if (state is HomeProductsLoadingState) {
                  return const Center(
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                }
                return SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        products?.length ??
                        0, // Replace with your actual item count
                    itemBuilder: (context, index) {
                      return Container(
                        width: 195,
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  products?[index].image ??
                                      '', // Replace with your image URL
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              products?[index].name ??
                                  "", // Replace with your item title
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                products?[index].description ??
                                    '', // Replace with your item description
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    '\$${products?[index].price ?? 0}',
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Spacer(),
                                FloatingActionButton(
                                  mini: true,
                                  shape: CircleBorder(),
                                  backgroundColor: Colors.green,

                                  onPressed: () {
                                    throw Exception("Add to cart functionality not implemented yet.");
                                  },
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: const Icon(Icons.menu),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 50),
        child: Row(
          children: const [
            Icon(Icons.pin_drop),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.chevron_down,
                      size: 20,
                      color: Colors.green,
                    ),
                  ],
                ),
                Text(
                  '123 Main St, City, Country',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Handle notification icon press
          },
        ),
      ],
    );
  }
}
