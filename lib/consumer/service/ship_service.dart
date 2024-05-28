import 'package:basicfirebase/consumer/domain/ship_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShipService {

  late final ShipRepository shipRepository;

  ShipService(FirebaseFirestore firebaseFireStore) {
    shipRepository = ShipRepository(firebaseFirestore: firebaseFireStore);
  }


}