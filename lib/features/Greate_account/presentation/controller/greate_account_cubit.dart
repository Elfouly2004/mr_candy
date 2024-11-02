import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mrcandy/features/Greate_account/presentation/view/greate%20acoount.dart';
import 'dart:convert'; // لإضافة مكتبة dart:convert
import 'dart:io';

import '../../../login/data/model/user_model.dart';
import '../../data/model/model.dart';
import '../../data/repo/Greate_account_repo.dart'; // لإضافة مكتبة dart:io لقراءة ملفات الصور
part 'greate_account_state.dart';

class GreateAccountCubit extends Cubit<GreateAccountState> {
  GreateAccountCubit(this.greateAccountRepo) : super(GreateAccountInitial());



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
      emit(GreateAccountphotoSuccess());
      myPhoto = value;
    },);
  }

 final  GreateAccountRepo greateAccountRepo;

  Future<void> Greateacoount() async {

    emit(GreateAccountLoadingState());


      debugPrint("Loading Cubit");
    try {
      String? base64String;
      if (myPhoto != null) {
        File imageFile = File(myPhoto!.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        base64String = base64Encode(imageBytes);
      }


      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(Email.text.trim());

      if (!emailValid) {
        emit(GreateAccountFailureState(errorMessage: " Please enter a correct email."));
      } else if (Name.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Name cannot be empty."));
      } else if (Phone.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Phone number is required."));
      } else if (password.text.isEmpty) {
        emit(GreateAccountFailureState(errorMessage: "Password cannot be empty."));
      } else if (base64String == null) {
        emit(GreateAccountFailureState(errorMessage: "Please choose a photo."));
      } else{
        // Proceed with account creation if all fields are valid
        debugPrint("function is read ");
        var result = await greateAccountRepo.Greate_account(
          userModelToRegister: UserModelToRegister(
            name: Name.text.trim(),
            email: Email.text.trim(),
            phone: Phone.text.trim(),
            image: base64String,
            password: password.text.trim(),
          ),
        );


        result.fold((left) {
          // print("Error: ${left.message}");
          emit(GreateAccountFailureState(errorMessage: left.message));
        }, (right)async {
          debugPrint("Success");
          var box = Hive.box("setting");
          await box.put("token", right.token);
          // debugPrint("Token app : ${box.get("token")}");

          emit(GreateAccountSuccessState(userModel: right));
        });
      }

    } catch (e) {
      print("Exception: $e"); // Catch and print any excpteption
    }
  }



}

//import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meta/meta.dart';
// import 'package:mrcandy/features/Greate_account/presentation/view/greate%20acoount.dart';
// import 'dart:convert'; // لإضافة مكتبة dart:convert
// import 'dart:io';
//
// import '../../../../core/utils/app_colors.dart';
// import '../../../login/data/model/user_model.dart';
// import '../../data/model/model.dart';
// import '../../data/repo/Greate_account_repo.dart'; // لإضافة مكتبة dart:io لقراءة ملفات الصور
// part 'greate_account_state.dart';
//
// class GreateAccountCubit extends Cubit<GreateAccountState> {
//   GreateAccountCubit(this.greateAccountRepo) : super(GreateAccountInitial());
//
//
//
//   final TextEditingController Email = TextEditingController();
//   final TextEditingController Name = TextEditingController();
//   final TextEditingController Phone = TextEditingController();
//   final TextEditingController password = TextEditingController();
//
//
//   XFile ? myPhoto;
//   // myPhoto = null ;
//   Future<XFile?> pickImage() async {
//     ImagePicker picker = ImagePicker();
//
//     XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     return image;
//   }
//
//
//   choosephoto() {
//     pickImage().then((value) {
//       emit(GreateAccountphotoSuccess());
//       myPhoto = value;
//     },);
//   }
//
//  final  GreateAccountRepo greateAccountRepo;
//
//   Future<void> Greateacoount(BuildContext context) async {
//     emit(GreateAccountLoadingState());
//     try {
//       String? base64String;
//       if (myPhoto != null) {
//         File imageFile = File(myPhoto!.path);
//         List<int> imageBytes = await imageFile.readAsBytes();
//         base64String = base64Encode(imageBytes);
//       }
//
//       final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//           .hasMatch(Email.text.trim());
//
//       if (!emailValid) {
//         emit(GreateAccountFailureState(errorMessage: " Please enter a correct email."));
//       } else if (Name.text.isEmpty) {
//         emit(GreateAccountFailureState(errorMessage: "Name cannot be empty."));
//       } else if (Phone.text.isEmpty) {
//         emit(GreateAccountFailureState(errorMessage: "Phone number is required."));
//       } else if (password.text.isEmpty) {
//         emit(GreateAccountFailureState(errorMessage: "Password cannot be empty."));
//       } else if (base64String == null) {
//         emit(GreateAccountFailureState(errorMessage: "Please choose a photo."));
//       } else {
//         // Proceed with account creation if all fields are valid
//         var result = await greateAccountRepo.Greate_account(
//           userModelToRegister: UserModelToRegister(
//             name: Name.text.trim(),
//             email: Email.text.trim(),
//             phone: Phone.text.trim(),
//             image: base64String,
//             password: password.text.trim(),
//           ),
//         );
//
//
//         emit(GreateAccountfinish());
//
//         result.fold((left) {
//           print("Error: ${left.message}");
//           emit(GreateAccountFailureState(errorMessage: left.message));
//         }, (right)async {
//
//           var box = Hive.box("setting");
//           await box.put("token", right.token);
//
//           // print("Success: Account Created");
//           emit(GreateAccountSuccessState(userModel: right));
//         });
//       }
//     } catch (e) {
//       print("Exception: $e");
//       emit(GreateAccountFailureState(errorMessage: "An unexpected error occurred."));
//     }
//   }
//
//
//
// }