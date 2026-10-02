import 'package:intern_project/core/usecase/usecase.dart';
import 'package:intern_project/features/firebase/domain/repo/firebase_repo.dart';

class GetUserDataUsecase implements UsecaseWithoutParams {
  final FirebaseRepo _firebaseRepo;

  GetUserDataUsecase({required FirebaseRepo firebaseRepo})
      : _firebaseRepo = firebaseRepo;

  @override
  Future<void> call() async {

    await _firebaseRepo.getUserData();
    
  }
}
