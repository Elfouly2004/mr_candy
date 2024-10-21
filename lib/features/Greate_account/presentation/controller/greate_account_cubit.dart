import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'greate_account_state.dart';

class GreateAccountCubit extends Cubit<GreateAccountState> {
  GreateAccountCubit() : super(GreateAccountInitial());



  final TextEditingController Email = TextEditingController();
  final TextEditingController Name = TextEditingController();
  final TextEditingController Phone = TextEditingController();
  final TextEditingController password = TextEditingController();




  XFile ? myPhoto;

  // myPhoto = null ;
  Future<XFile?> pickImage() async {
    ImagePicker picker = ImagePicker();

    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  choosephoto() {
    pickImage().then((value) {
      emit(GreateAccountSuccessState());
      myPhoto = value;
    },);
  }
  //
  // XFile? myPhoto;
  //
  // Future<XFile?> pickImage() async {
  //   ImagePicker picker = ImagePicker();
  //   XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //
  //   return image;
  // }
  //
  // void choosePhoto() {
  //   pickImage().then((value) async {
  //     if (value != null) {
  //       myPhoto = value as XFile?;
  //
  //       // تحويل الصورة إلى Base64
  //       final bytes = await File(myPhoto!.path).readAsBytes();
  //       String base64Image = base64Encode(bytes);
  //
  //       // هنا يمكنك استخدام base64Image في API
  //       emit(GreateAccountSuccessState(base64Image));
  //     }
  //   }).catchError((error) {
  //     // التعامل مع الأخطاء إذا لزم الأمر
  //     emit(GreateAccountFailureState(errorMessage: error.toString()));
  //   });
  // }


}
