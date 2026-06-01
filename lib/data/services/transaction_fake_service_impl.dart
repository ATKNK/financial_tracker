import 'dart:convert';

import 'package:financial_tracker/common/errors/errors_messagens.dart';
import 'package:financial_tracker/helper/transaction_fake_repository.dart';

import '../../common/errors/errors_classes.dart';
import '../../common/patterns/result.dart';
import '../../domain/entity/transaction_entity.dart';
import 'transaction_storage_contract.dart';

class TransactionFakeServiceImpl implements TransactionStorageContract {
  final TransactionFakeRepository _api = TransactionFakeRepository();

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchAllTransacions() async {
    try {
      var result = await _api.getData();

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions =
          jsonList
              .map(
                (item) =>
                    TransactionEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList();
      return Success(transactions); // Retorna um exemplo.
    } on DatasourceResultEmpty catch (e) {
      // Retorna erro em caso de falha.
      return Error(DatasourceResultEmpty(e.toString()));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<TransactionEntity, Failure>> fetchTransacion(String id) async {
    try {
      final result = await _api.getData();
      final List<dynamic> jsonList = jsonDecode(result);
      final transactions =
          jsonList
              .map(
                (item) =>
                    TransactionEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList();
      final transaction = transactions.firstWhere(
        (element) => element.id == id,
        orElse: () => throw RecordNotFound(MessagesError.recordNotFound),
      );
      return Success(transaction);
    } on RecordNotFound catch (e) {
      return Error(RecordNotFound(e.toString()));
    } on DatasourceResultEmpty catch (e) {
      return Error(DatasourceResultEmpty(e.toString()));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      return Error(DefaultError('Erro ao buscar transação: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByTipe(
    TransactionType type,
  ) {
    // TODO: implement fetchTransacionsByTipe
    throw UnimplementedError();
  }

  @override
  Future<Result<void, Failure>> updateTransaction(String id) async {
    try {
      await _api.updateData(id);

      return Success(null);
    } on RecordNotFound catch (e) {
      return Error(RecordNotFound('Na atualização: ${e.toString()}'));
    } on APIFailure catch (e) {
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      return Error(
        DefaultError('Erro ao atualizar a transação: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void, Failure>> removeTransacion(String id) async {
    try {
      await _api.deleteData(id);

      return Success(null);
    } on RecordNotFound catch (e) {
      // Retorna erro em caso de falha.
      return Error(RecordNotFound('Na Exclusão: ${e.toString()}'));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void, Failure>> storeTransacion(
    TransactionEntity transaction,
  ) async {
    try {
      await _api.addData(transaction.toJson());

      return Success(null);
    } on InvalidData catch (e) {
      // Retorna erro em caso de falha.
      return Error(InvalidData('Na Inclusão: ${e.toString()}'));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao buscar o estudante: ${e.toString()}'));
    }
  }

  @override
  Future<Result<List<TransactionEntity>, Failure>> fetchTransacionsByDate(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      var result = await _api.getDataByDateRange(startDate, endDate);

      final List<dynamic> jsonList = jsonDecode(result);

      final transactions =
          jsonList
              .map(
                (item) =>
                    TransactionEntity.fromMap(item as Map<String, dynamic>),
              )
              .toList();
      return Success(transactions); // Retorna um exemplo.
    } on DatasourceResultEmpty catch (e) {
      // Retorna erro em caso de falha.
      return Error(DatasourceResultEmpty(e.toString()));
    } on APIFailure catch (e) {
      // Retorna erro em caso de falha.
      return Error(APIFailure(e.toString()));
    } on Exception catch (e) {
      // Retorna erro em caso de falha.
      return Error(DefaultError('Erro ao Transações: ${e.toString()}'));
    }
  }
}
