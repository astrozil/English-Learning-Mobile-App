part of 'firebase_cubit.dart';

@immutable
sealed class FirebaseState {}

final class FirebaseInitial extends FirebaseState {}

final class FirebaseLoading extends FirebaseState {}

final class DataFetched extends FirebaseState {}
