part of sumibi;

void _noOp(String _, Map<String, dynamic> __) {}

class SumibiFirestore implements Firestore {
  SumibiFirestore(this._delegate,
      {Hook onSetDataHook = _noOp, Hook onUpdateDataHook = _noOp})
      : _onSetDataHook = onSetDataHook,
        _onUpdateDataHook = onUpdateDataHook;

  final Firestore _delegate;
  final Hook _onSetDataHook;
  final Hook _onUpdateDataHook;

  @override
  FirebaseApp get app => _delegate.app;

  @override
  WriteBatch batch() =>
      _WriteBatch(_delegate.batch(), _onSetDataHook, _onUpdateDataHook);

  @override
  CollectionReference collection(String path) => _CollectionReference(
      _delegate.collection(path), _onSetDataHook, _onUpdateDataHook);

  @override
  Query collectionGroup(String path) => _delegate.collectionGroup(path);

  @override
  DocumentReference document(String path) => _DocumentReference(
      _delegate.document(path), _onSetDataHook, _onUpdateDataHook);

  @Deprecated('Use the persistenceEnabled parameter of the [settings] method')
  @override
  Future<void> enablePersistence(bool enable) =>
      _delegate.enablePersistence(enable);

  @override
  Future<Map<String, dynamic>> runTransaction(
          TransactionHandler transactionHandler,
          {Duration timeout = const Duration(seconds: 5)}) =>
      _delegate.runTransaction(
          (transaction) => transactionHandler(
              _Transaction(transaction, _onSetDataHook, _onUpdateDataHook)),
          timeout: timeout);

  @override
  Future<Function> settings(
          {bool persistenceEnabled,
          String host,
          bool sslEnabled,
          int cacheSizeBytes}) =>
      _delegate.settings(
        persistenceEnabled: persistenceEnabled,
        host: host,
        sslEnabled: sslEnabled,
        cacheSizeBytes: cacheSizeBytes,
      );
}
