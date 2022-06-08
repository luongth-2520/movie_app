import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/repository/movie_repository.dart';

final detailViewModelProvider = ChangeNotifierProvider((ref) => DetailViewModel(movieRepository: MovieRepository()));

class DetailViewModel extends ChangeNotifier {
  DetailViewModel({required this.movieRepository});
  final MovieRepository movieRepository;
  final firestore = FirebaseFirestore.instance;

  AsyncValue<List<Cast>> casts = const AsyncValue.loading();

  Future getCasts(int movieId) async {
    try {
      final data = await movieRepository.getCasts(movieId);
      casts = AsyncValue.data(data.cast ?? []);
    } catch (e) {
      casts = AsyncValue.error(e);
    }
    notifyListeners();
  }

  Future<void> addUser() {
    final usersRef = firestore.collection('users');
    // Call the user's CollectionReference to add a new user
    return usersRef
        .add({'full_name': "Stokes", 'company': "Stokes and Sons", 'age': 42})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void getStreamUser() {
    final usersRef = firestore.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, options) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );

    usersRef.snapshots().listen((event) {
      print(event);
    });
  }
}

class UserModel {
  final String fullName;
  final String company;
  final int age;

  UserModel({required this.fullName, required this.company, required this.age});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(fullName: json['full_name'] as String, company: json['company'] as String, age: json['age'] as int);

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'company': company,
      'age': age,
    };
  }
}
