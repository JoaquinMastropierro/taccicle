import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taccicle/presentation/states/providers/form_provider/register_form_provider.dart';
import 'package:taccicle/presentation/ui/common/custom_image_picker.dart';

class RegisterSecondStep extends StatelessWidget {
   RegisterSecondStep({
    super.key
  });

  static final imgPrefix = "https://res.cloudinary.com/dlerubxw0/image/upload/v1679963032";

  final List images =  [
   {
    "src":"$imgPrefix/avatars/defaultAvatars/fgargyszxhmctlos6nff",
    "id":0,
    "picked":false,
    "custom":false,
    "folder":"/avatars/defaultAvatars/fgargyszxhmctlos6nff"
   },
   {
    "src":"$imgPrefix/avatars/defaultAvatars/f1z8qs9mzp6tzplvitc9",
    "id":1,
    "picked":false,
    "custom":false,
    "folder":"/avatars/defaultAvatars/f1z8qs9mzp6tzplvitc9"

   },
   {
    "src":"$imgPrefix/avatars/defaultAvatars/kg34grq0jfngkfu79sz1",
    "id":2,
    "picked":false,
    "custom":false,
    "folder":"/avatars/defaultAvatars/kg34grq0jfngkfu79sz1"

   },
      {
    "src":"$imgPrefix/avatars/defaultAvatars/m5ilgsq3knxlwjzjr52j",
    "id":3,
    "picked":false,
    "custom":false,
    "folder":"/avatars/defaultAvatars/m5ilgsq3knxlwjzjr52j"
   },
  ];
  
  @override
  Widget build(BuildContext context) {

    final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

    onChangeSelection(Map? img){
      registerFormProvider.setPickedImg(img);
    }


    return SizedBox(
      height: 300,
      child: CustomImagePicker(defaultImages: images, onChangeSelection: onChangeSelection,),
    );
  }

 
}

