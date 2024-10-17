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


}
