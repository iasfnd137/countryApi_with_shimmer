import 'package:country_api/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class DetailScreen extends StatelessWidget {
  final CountryModel countryModel;
  const DetailScreen({Key? key, required this.countryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        title: Text(countryModel.name,style: const TextStyle(color: Colors.black),),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/wdmp.png'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
              opacity: 0.5,
                  child: SvgPicture.network(countryModel.flag,height: MediaQuery.of(context).size.height*0.30,width: double.infinity,)),
              const Divider(
                thickness: 3,
                color: Colors.white,
              ),
              const SizedBox(height: 15,),
              //if else statemant :full colon thk if staemnt hy usky bad else hy
              //countryModel.borders!=null?const Text('Borders'):const Text(''), hamary sat ye tariqa bi ho sakta hy
              Visibility(
                  visible: countryModel.borders !=null?true:false,
                  child: const Text('Borders',style: TextStyle(color: Colors.white,fontSize: 25,decoration: TextDecoration.underline),)),
              countryModel.borders!=null?Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: countryModel.borders!.length,
                  itemBuilder: (context,index){
                    var bar= countryModel.borders![index];
                    return Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Container(
                        height: 80,
                        width: 80,
                        child: Center(child: Text(bar)),
                      ),
                    );
                  },
                ),
              ):const Text(''),
             const SizedBox(height: 15,),
              Text('Region: ${countryModel.region}',style: const TextStyle(fontSize: 20,color: Colors.white),),
              const Divider(
                thickness: 3,
                color: Colors.white,
              ),
              const SizedBox(height: 15,),
              Text('SubRegion: ${countryModel.subregion}',style: const TextStyle(fontSize: 20,color: Colors.white),),
              const Divider(
                thickness: 3,
                color: Colors.white,
              ),
              const SizedBox(height: 15,),
              Text('Population: ${countryModel.population}',style: const TextStyle(fontSize: 20,color: Colors.white),),
              const Divider(
                thickness: 3,
                color: Colors.white,
              ),
              const SizedBox(height: 15,),
              Visibility(
                 visible: countryModel.capital !=null?true:false,
                  child: Text('Capital: ${countryModel.capital}',style: const TextStyle(fontSize: 20,color: Colors.white),)),
              Visibility(
                visible: countryModel.capital !=null?true:false,
                child: const Divider(
                  thickness: 3,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
