
import 'package:beasy_client/services/company_services.dart';
import 'package:beasy_client/services/profile_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BeasyApi {
  BeasyApi._internal();

  static final beasyApi = BeasyApi._internal();

  factory BeasyApi() {
    return beasyApi;
  }

  static FirebaseFirestore store = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  ProfileServices profileServices = ProfileServices(auth: auth, store: store);
  CompanyServices companyServices = CompanyServices(auth: auth, store: store);
}
