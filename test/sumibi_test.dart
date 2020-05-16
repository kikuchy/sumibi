import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:sumibi/sumibi.dart';

import 'mocks.dart';

void main() {
  group("$SumibiFirestore", () {
    test("can propagate hooks for child documents", () async {
      final store = MockFirestore();
      final document = MockDocumentReference();
      when(store.document(any)).thenReturn(document);
      when(document.setData(any))
          .thenAnswer((realInvocation) => Future.value());

      var callCount = 0;
      final hook = (_, __) {
        callCount++;
      };
      final sumibi =
          SumibiFirestore(store, onSetDataHook: hook, onUpdateDataHook: hook);
      await sumibi.document("foo").setData({});
      await sumibi.document("foo").updateData({});
      expect(callCount, 2);
    });

    test("can propagate hooks for child collection", () async {
      final store = MockFirestore();
      final collection = MockCollectionReference();
      final document = MockDocumentReference();
      when(store.collection(any)).thenReturn(collection);
      when(collection.document(any)).thenReturn(document);
      when(document.setData(any))
          .thenAnswer((realInvocation) => Future.value());

      var callCount = 0;
      final hook = (_, __) {
        callCount++;
      };
      final sumibi =
          SumibiFirestore(store, onSetDataHook: hook, onUpdateDataHook: hook);
      await sumibi.collection("foo").add({});
      expect(callCount, 1);
    });

    test("can propagate hooks for batch", () {
      final store = MockFirestore();
      final batch = MockWriteBatch();
      final document = MockDocumentReference();
      when(store.batch()).thenReturn(batch);

      var callCount = 0;
      final hook = (_, __) {
        callCount++;
      };
      final sumibi =
          SumibiFirestore(store, onSetDataHook: hook, onUpdateDataHook: hook);
      sumibi.batch()
        ..setData(document, {})
        ..updateData(document, {});
      expect(callCount, 2);
    });

    test("can propagate hooks for transaction", () async {
      final store = MockFirestore();
      final transaction = MockTransaction();
      final document = MockDocumentReference();
      when(store.runTransaction(any)).thenAnswer((realInvocation) =>
          realInvocation.positionalArguments.first.call(transaction));

      var callCount = 0;
      final hook = (_, __) {
        callCount++;
      };
      final sumibi =
          SumibiFirestore(store, onSetDataHook: hook, onUpdateDataHook: hook);
      await sumibi.runTransaction((transaction) async {
        await transaction.set(document, {});
        await transaction.update(document, {});
      });
      expect(callCount, 2);
    });
  });

  group("DocumentReference", () {
    test("should call the hook on setData", () {
      final store = MockFirestore();
      final document = MockDocumentReference();
      when(store.document(any)).thenReturn(document);

      void hook(String path, Map<String, dynamic> data) {
        data["createdAt"] = FieldValue.serverTimestamp();
      }

      final sumibi = SumibiFirestore(store, onSetDataHook: hook);
      final hookedDocument = sumibi.document("foo");
      hookedDocument.setData({"name": "Foobar"});
      expect(
          verify(document.setData(captureAny)).captured.first,
          equals({
            "name": "Foobar",
            "createdAt": FieldValue.serverTimestamp(),
          }));
    });

    test("should call the hook on updateData", () {
      final store = MockFirestore();
      final document = MockDocumentReference();
      when(store.document(any)).thenReturn(document);

      void hook(String path, Map<String, dynamic> data) {
        data["updatedAt"] = FieldValue.serverTimestamp();
      }

      final sumibi = SumibiFirestore(store, onUpdateDataHook: hook);
      final hookedDocument = sumibi.document("foo");
      hookedDocument.updateData({"name": "Foobar"});
      expect(
          verify(document.updateData(captureAny)).captured.first,
          equals({
            "name": "Foobar",
            "updatedAt": FieldValue.serverTimestamp(),
          }));
    });
  });
}
