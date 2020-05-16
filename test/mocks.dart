import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/mockito.dart';

class MockDocumentReference extends Mock implements DocumentReference {}

class MockCollectionReference extends Mock implements CollectionReference {}

class MockWriteBatch extends Mock implements WriteBatch {}

class MockTransaction extends Mock implements Transaction {}

class MockFirestore extends Mock implements Firestore {}
