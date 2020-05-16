part of sumibi;

class _CollectionReference implements CollectionReference {
  _CollectionReference(this._delegate, this._onSetData, this._onUpdateData);

  final CollectionReference _delegate;
  final Hook _onSetData;
  final Hook _onUpdateData;

  @override
  String get id => _delegate.id;

  @override
  DocumentReference parent() =>
      _DocumentReference(_delegate.parent(), _onSetData, _onUpdateData);

  @override
  String get path => _delegate.path;

  @override
  DocumentReference document([String path]) =>
      _DocumentReference(_delegate.document(path), _onSetData, _onUpdateData);

  @override
  Future<DocumentReference> add(Map<String, dynamic> data) async {
    final DocumentReference newDocument = document();
    await newDocument.setData(data);
    return newDocument;
  }

  @override
  Map<String, dynamic> buildArguments() => _delegate.buildArguments();

  @override
  Query endAt(List<dynamic> values) => _delegate.endAt(values);

  @override
  Query endAtDocument(DocumentSnapshot documentSnapshot) =>
      _delegate.endAtDocument(documentSnapshot);

  @override
  Query endBefore(List<dynamic> values) => _delegate.endBefore(values);

  @override
  Query endBeforeDocument(DocumentSnapshot documentSnapshot) =>
      _delegate.endBeforeDocument(documentSnapshot);

  @override
  Firestore get firestore => _delegate.firestore;

  @override
  Future<QuerySnapshot> getDocuments({Source source = Source.serverAndCache}) =>
      _delegate.getDocuments(source: source);

  @override
  Query limit(int length) => _delegate.limit(length);

  @override
  Query orderBy(dynamic field, {bool descending = false}) =>
      _delegate.orderBy(field, descending: descending);

  @override
  CollectionReference reference() =>
      _CollectionReference(_delegate.reference(), _onSetData, _onUpdateData);

  @override
  Stream<QuerySnapshot> snapshots({bool includeMetadataChanges = false}) =>
      _delegate.snapshots(includeMetadataChanges: includeMetadataChanges);

  @override
  Query startAfter(List<dynamic> values) => _delegate.startAfter(values);

  @override
  Query startAfterDocument(DocumentSnapshot documentSnapshot) =>
      _delegate.startAfterDocument(documentSnapshot);

  @override
  Query startAt(List<dynamic> values) => _delegate.startAt(values);

  @override
  Query startAtDocument(DocumentSnapshot documentSnapshot) =>
      _delegate.startAtDocument(documentSnapshot);

  @override
  Query where(dynamic field,
          {dynamic isEqualTo,
          dynamic isLessThan,
          dynamic isLessThanOrEqualTo,
          dynamic isGreaterThan,
          dynamic isGreaterThanOrEqualTo,
          dynamic arrayContains,
          List<dynamic> arrayContainsAny,
          List<dynamic> whereIn,
          bool isNull}) =>
      _delegate.where(
        field,
        isEqualTo: isEqualTo,
        isLessThan: isLessThan,
        isLessThanOrEqualTo: isLessThanOrEqualTo,
        isGreaterThan: isGreaterThan,
        isGreaterThanOrEqualTo: isGreaterThanOrEqualTo,
        arrayContains: arrayContains,
        arrayContainsAny: arrayContainsAny,
        whereIn: whereIn,
        isNull: isNull,
      );
}
