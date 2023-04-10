import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomImagePicker extends StatefulWidget {
   CustomImagePicker({
    super.key,
    required this.defaultImages, required this.onChangeSelection,
  });

  List defaultImages;
  final Function onChangeSelection;
  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {

  List images = [];
  
  @override
  void initState() {
    
    setState(() {
      images = widget.defaultImages;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Elija avatar")
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10) ,
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            
            itemBuilder: (context, index) {
            
                Map img = images[index];
                
                return ImagePickerCard(img: img, onTap: (tappedImage){
                  
                  var pickedImage = tappedImage['picked'] ? null : tappedImage;

                  widget.onChangeSelection(pickedImage);

                  setState(() {
                   
                       images = images.map((e) {

                      if(e['id'] == tappedImage['id']){
                        e['picked'] = !e['picked'];
                        return e;
                      }
                      e['picked'] = false;
                      

                      return e;

                  } ).toList(); 
                  });

                 
                },
              );  
              
            },
            
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("O suba una imagen"),
            IconButton(onPressed: onPressUpload, icon:const Icon(Icons.upload))
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  void onPressUpload() async {
      
      var result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg','jpeg', 'png'],
        allowMultiple: true,
        withData: true
      );

      if(result == null) return;

      PlatformFile file = result.files.first;

      var newImage  = {
          "bytes":file.bytes!,
          "id":images.length,
          "picked":true,
          "custom":true
      };

      setState(() { 
        
        images = images.map((e) {
          e['picked'] = false;
          return e;
        }).toList();
        
        if(images.first['custom']){
            images.removeAt(0);
        }
        images.insert(0, newImage);

      });

      widget.onChangeSelection(newImage);
  }
}

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({
    super.key,
    required this.img, 
    required this.onTap,
  });

  final Function onTap;
  final Map img;

  @override
  

  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap(img);
      },
      child: Container(
        margin: EdgeInsets.only(left: 5),
        child: Ink(
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),  
            boxShadow: const [
              BoxShadow(color: Color.fromARGB(255, 219, 219, 219), blurRadius: 2, spreadRadius: 2)
            ],
            image:DecorationImage(image: generateImage(), fit: BoxFit.fill)
             
          ),
          width: 180,
          child: pickedIndicator()
        ),
      ),
    );
  }

  ImageProvider generateImage() {

    if(img['src'] != null){
      
      return NetworkImage(img['src']);
    }

    return MemoryImage(img['bytes']);

  } 

  Padding pickedIndicator() {
    
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(img['picked'] ? Icons.check_box : Icons.check_box_outline_blank, color: img['picked'] ? Colors.blue : Colors.grey),
            
          ],
        ),
      );
  }
}