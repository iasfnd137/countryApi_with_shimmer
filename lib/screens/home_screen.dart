import 'dart:async';
import 'dart:convert';
import 'package:country_api/provider/country_api_provider.dart';
import 'package:country_api/screens/detail_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:country_api/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late StreamController _streamController;
  // late Stream _stream;
  // var allCountries = <CountryModel>[];

  // void getAllCountries() async {
  //   _streamController.add('loading');
  //   var url = 'https://restcountries.com/v2/all';
  //   var response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     for (var countries in jsonData) {
  //       CountryModel countryModel = CountryModel.fromJSON(countries);
  //       allCountries.add(countryModel);
  //       _streamController.add(allCountries);
  //     }
  //     print(allCountries.length);
  //   } else {
  //     _streamController.add('went wrong');
  //   }
  // }
  bool isLoading = false;

  @override
  void initState() {
    var pro = Provider.of<CountryApiProvider>(context,listen: false);
    pro.getAllCountries();
    Future.delayed(Duration(seconds: 10),(){
      setState(() {
        isLoading = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Countries List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('assets/wdmp.png'), fit: BoxFit.cover)
        ),
        child: Consumer<CountryApiProvider>(
          builder: (context, data,_){
            return  ListView.separated(
              itemCount: data.allCountries.length,
              itemBuilder: (context, index) {
                var country = data.allCountries[index];
                return isLoading ?
                ListTile(
                        onTap: () {
                          Get.to(
                            DetailScreen(countryModel: country),
                            transition: Transition.zoom,
                            duration: const Duration(seconds: 1),
                          );
                        },
                        leading: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.network(
                            country.flag,fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          country.name,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                      ) : getShimmerLoading();
              }, separatorBuilder: (BuildContext context, int index) { return Divider(thickness: 3,); },
            );
          },
        ),
      ),
    );
  }
  Shimmer getShimmerLoading(){
    return Shimmer.fromColors(
        child: ListTile(
          leading: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          title: Container(
            height: 18,
            width: 80,
            color: Colors.grey.shade300,
            child: Text(
              '',
              style: const TextStyle(
                  color: Colors.black, fontSize: 20),
            ),
          ),
        )
        , baseColor: Colors.grey.shade300, highlightColor: Colors.grey.shade100);
  }
}

class NewSkeleton extends StatelessWidget {
  const NewSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Skeleton(height: 80,width: 80,),
        SizedBox(width: 10,),
        Skeleton(height: 25, width: 150),
      ],
    );
  }

}

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key, required this.height, required this.width,
  }) : super(key: key);

  final double height , width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(12),

      ),
    );
  }
}
