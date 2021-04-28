
import 'package:beasy_client/models/company_model/company.dart';
import 'package:beasy_client/models/company_model/company_stream.dart';
import 'package:beasy_client/models/company_model/stream_queue_item.dart';
import 'package:beasy_client/utils/api_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompanyServices {
  CompanyServices._internal();

  static final CompanyServices companyServices = CompanyServices._internal();

  FirebaseAuth auth;
  FirebaseFirestore store;
  Company curentUserCompany;
  Company companyModel = Company();

  factory CompanyServices({FirebaseAuth auth, FirebaseFirestore store}) {
    companyServices.auth = auth;
    companyServices.store = store;
    return companyServices;
  }

  Future<bool> createCompany({Company company}) async {
    print(company.companyName);
    try {
      company.companyOwnerId = auth.currentUser.uid;
      company.companyId = auth.currentUser.uid +
          DateTime.now().toString() +
          company.companyName;
      await store
          .collection(companiesCollectionPath)
          .doc(auth.currentUser.uid)
          .set(company.toJson());

      await store
          .collection(usersCollectionPath)
          .doc(auth.currentUser.uid)
          .update({"companyId": company.companyId});
      company.companyStreams.forEach((element) async {
        element.companyStreamId =
            company.companyStreams.indexOf(element).toString();
        await store
            .collection(companiesCollectionPath)
            .doc(auth.currentUser.uid)
            .collection("companyStream")
            .doc(company.companyStreams.indexOf(element).toString())
            .set(element.toJson());
        element.queue.forEach((e) async {
          await store
              .collection(companiesCollectionPath)
              .doc(auth.currentUser.uid)
              .collection("companyStream")
              .doc(company.companyStreams.indexOf(element).toString())
              .collection(streamQueuePath)
              .doc(element.queue.indexOf(e).toString())
              .set(e.toJson());
        });
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteCompany({String companyId}) async {
    try {
      await store
          .collection(companiesCollectionPath)
          .doc(auth.currentUser.uid)
          .delete();
      return true;
    } catch (e) {
      print(e.toString());

      return false;
    }
  }

  Future<bool> updateCompany({Company company}) async {
    try {
      await store
          .collection(companiesCollectionPath)
          .doc(auth.currentUser.uid)
          .update(company.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> getCompany({String companyid}) async {
    try {
      var res = await store
          .collection(companiesCollectionPath)
          .doc(auth.currentUser.uid)
          .get();

      if (res.exists) {
        curentUserCompany = Company.fromJson(res.data());
        var streams = await store
            .collection(companiesCollectionPath)
            .doc(auth.currentUser.uid)
            .collection(companyStreamsPath)
            .get();
        for (int i = 0; i < streams.docs.length; i++) {
          var element = streams.docs[i];
          var stream = CompanyStream.fromJson(element);
          var streamQueues = await store
              .collection(companiesCollectionPath)
              .doc(auth.currentUser.uid)
              .collection(companyStreamsPath)
              .doc(stream.companyStreamId)
              .collection(streamQueuePath)
              .get();
          print(streamQueues.size);
          streamQueues.docs.forEach((e) {
            stream.queue.add(StreamQueueItem.fromJson(e));
          });
          curentUserCompany.companyStreams.add(
            stream,
          );
        }
        return true;
      }

      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> switchStreamState({bool toValue, streamId}) async {
    try {
      await store
          .collection(companiesCollectionPath)
          .doc(auth.currentUser.uid)
          .collection("companyStream")
          .doc(streamId)
          .update({"companyStreamState": toValue});
      await getCompany(companyid: auth.currentUser.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Company>> getAllCompanyes() async {
    try {
      List<Company> companies = [];
      var res = await store.collection(companiesCollectionPath).get();

      var data = res.docs;

      for (int i = 0; i < data.length; i++) {
        var comp = await getCompanyData(data[i]);
        if (comp != null) {
          companies.add(comp);
        }
      }
      print(companies);
      return companies;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Company> getCompanyData(data) async {
    curentUserCompany = Company.fromJson(data.data());
    try {
      var streams = await store
          .collection(companiesCollectionPath)
          .doc(curentUserCompany.companyOwnerId)
          .collection(companyStreamsPath)
          .get();
      for (int i = 0; i < streams.docs.length; i++) {
        var element = streams.docs[i];
        var stream = CompanyStream.fromJson(element);
        var streamQueues = await store
            .collection(companiesCollectionPath)
            .doc(curentUserCompany.companyOwnerId)
            .collection(companyStreamsPath)
            .doc(stream.companyStreamId)
            .collection(streamQueuePath)
            .get();
        streamQueues.docs.forEach((e) {
          stream.queue.add(StreamQueueItem.fromJson(e));
        });
        curentUserCompany.companyStreams.add(
          stream,
        );
        return curentUserCompany;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> bookAStream(
      {String compmayId, String streamId, StreamQueueItem queueItem}) async {
    try {
      List<StreamQueueItem> castedQueues = [];
      var allQueues = await store
          .collection(companiesCollectionPath)
          .doc(compmayId)
          .collection(companyStreamsPath)
          .doc(streamId)
          .collection("streamQueuePath")
          .get();

      allQueues.docs.forEach((element) {
        castedQueues.add(StreamQueueItem.fromJson(element));
      });

      var isAvailableQueus = true;
      for (int i = 0; i < castedQueues.length; i++) {
        var curent = castedQueues[i];
        if (queueItem.startTime.isAfter(curent.startTime) &&
            queueItem.startTime.isBefore(curent.endTime)) {
          isAvailableQueus = false;
        }
        if (queueItem.startTime.isBefore(curent.startTime) &&
            queueItem.endTime.isAfter(curent.startTime)) {
          isAvailableQueus = false;
        }
      }
      print("is queue available${isAvailableQueus}");

      if (isAvailableQueus) {
        var l = allQueues.docs.length;

        var streamQueues = await store
            .collection(companiesCollectionPath)
            .doc(compmayId)
            .collection(companyStreamsPath)
            .doc(streamId)
            .collection("streamQueuePath")
            .doc(l.toString())
            .set(queueItem.toJson());
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
