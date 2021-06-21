import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:smart_gardern_app/constant.dart';

Future<dynamic> getID(images) async {
  var reponse = await http.post(
    Uri.parse('https://api.plant.id/v2/enqueue_identification'),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(<String, dynamic>{
      "api_key": plantIDkey,
      "images": images,
      "modifiers": ["crops_fast", "similar_images"],
    }),
  );
  return jsonDecode(reponse.body)['id'];
}

Future<dynamic> getInfor(id) async {
  var reponse = await http.post(
    Uri.parse(
        'https://api.plant.id/v2/get_identification_result/' + id.toString()),
    headers: <String, String>{
      "Content-Type": "application/json",
    },
    body: jsonEncode(<String, dynamic>{
      "api_key": plantIDkey,
      "plant_language": "en",
      "plant_details": [
        "common_names",
        "taxonomy",
      ],
    }),
  );
  final common_names = jsonDecode(reponse.body)['suggestions'][0]
      ['plant_details']['common_names'];
  final genus = jsonDecode(reponse.body)['suggestions'][0]['plant_details']
      ['structured_name']['genus'];
  final prob = jsonDecode(reponse.body)['suggestions'][0]['probability'];
  return [common_names.join(", "), genus, prob];
}

class PlantIdentificationScreen extends StatefulWidget {
  const PlantIdentificationScreen({Key? key}) : super(key: key);

  @override
  _PlantIdentificationScreenState createState() =>
      _PlantIdentificationScreenState();
}

class _PlantIdentificationScreenState extends State<PlantIdentificationScreen> {
  late File _image;
  final picker = ImagePicker();
  var encodedImage;
  bool display = false;
  getImage() async {
    final pickedFile =
        (await picker.getImage(source: ImageSource.gallery, imageQuality: 50));
    setState(() {
      _image = File(pickedFile!.path);
      encodedImage = [base64Encode(_image.readAsBytesSync())];
      display = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (display == false)
            ? Center(child: Text("No image has been selected."))
            : PlantInfoBuilder(
                image: _image,
                encodedImage: encodedImage,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}

class PlantInfoBuilder extends StatefulWidget {
  const PlantInfoBuilder({
    Key? key,
    this.image,
    this.encodedImage,
  }) : super(key: key);
  final image;
  final encodedImage;

  @override
  _PlantInfoBuilderState createState() => _PlantInfoBuilderState();
}

class _PlantInfoBuilderState extends State<PlantInfoBuilder> {
  Future<dynamic> getPlantIdentification(encodedImage) async {
    final id = await getID(encodedImage);
    final plantInfor = await getInfor(id);
    return plantInfor;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: getPlantIdentification(widget.encodedImage),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                child: Image.file(widget.image),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      child:
                          Text('Common names: ' + snapshot.data[0].toString()),
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding, vertical: 2.5),
                      margin:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      child: Text('Genus: ' + snapshot.data[1].toString()),
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding, vertical: 2.5),
                      margin:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(29),
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      child: Text('Confidence: ' + snapshot.data[2].toString()),
                      padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding, vertical: 2.5),
                      margin:
                          EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
