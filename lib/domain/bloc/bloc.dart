import 'dart:async';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/main_old.dart';
import 'package:gql/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../data/graphql_operation/queries/index.dart';

// to run the example, replace <YOUR_PERSONAL_ACCESS_TOKEN> with your GitHub token in ../local.dart

const bool ENABLE_WEBSOCKETS = true;

class Repo {
  const Repo({this.id, this.name, this.viewerHasStarred});
  final String? id;
  final String? name;
  final bool? viewerHasStarred;
}

class GlobalBloc {
  static final GlobalBloc _instance = GlobalBloc._internal();
  GraphQLClient? _client;
  GraphQLClient? _clientWithoutToken;

  Stream<QueryResult>? subscription;

  StreamSubscription<QueryResult>? subscriptionStream;
  StreamSubscription<QueryResult>? subscriptionStreamForChat;

  factory GlobalBloc() {
    return _instance;
  }
  GlobalBloc._internal() {
    final httpLink = HttpLink(
      // 'http://192.168.219.100:4000/api',
      'https://api.finutss.com/graphql',
      // 'http://192.168.29.71:8093/graphql'
    );

    final authLink = AuthLink(
      // ignore: undefined_identifier




      getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
    );

    var link = authLink.concat(httpLink);

    if (ENABLE_WEBSOCKETS) {
      // final websocketLink = WebSocketLink('ws://192.168.219.100:4000/subscriptions');
      final websocketLink =
          WebSocketLink('wss://api.finutss.com/subscriptions');

      link = Link.split(
        (request) => request.isSubscription,
        websocketLink,
        link,
      );
    }
    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );
    _client = GraphQLClient(
      cache: GraphQLCache(),
      link: link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );

    _clientWithoutToken = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
  }

  Future<Map<String, dynamic>> queryRepo(DocumentNode readRepositories, map,
      [bool withoutToken = false]) async {
    if (withoutToken == false &&
        ACCESS_TOKEN_EXPIRES_AT != 0 &&
        ACCESS_TOKEN_EXPIRES_AT < DateTime.now().millisecondsSinceEpoch) {
      await updateAccessToken();
      return await queryRequest(readRepositories, map, withoutToken);
    } else {
      return await queryRequest(readRepositories, map, withoutToken);
    }
  }

  Future<Map<String, dynamic>> queryMutate(
      DocumentNode readRepositories, Map<String, dynamic> map,
      [bool withoutToken = false]) async {
    if (withoutToken == false &&
        ACCESS_TOKEN_EXPIRES_AT != 0 &&
        ACCESS_TOKEN_EXPIRES_AT < DateTime.now().millisecondsSinceEpoch) {
      await updateAccessToken();
      return await mutateRequest(readRepositories, map, withoutToken);
    } else {
      return await mutateRequest(readRepositories, map, withoutToken);
    }
  }

  Future<void> updateAccessToken() async {
    if (YOUR_PERSONAL_REFRESH_TOKEN.isNotEmpty) {
      var res = await mutateRequest(DefaultQueries.UPDATE_TOKEN,
          {"refreshToken": YOUR_PERSONAL_REFRESH_TOKEN}, true);

      await LocalDB.remove('token');
      await LocalDB.remove('accessTokenExpiresAt');
      await LocalDB.remove('refreshToken');
      await LocalDB.remove('refreshTokenExpiresAt');

      YOUR_PERSONAL_ACCESS_TOKEN =
          await res["data"]["updateTokenPair"]["accessToken"];
      ACCESS_TOKEN_EXPIRES_AT =
          await res["data"]["updateTokenPair"]["accessTokenExpiresAt"];
      YOUR_PERSONAL_REFRESH_TOKEN =
          await res["data"]["updateTokenPair"]["refreshToken"];
      REFRESH_TOKEN_EXPIRES_AT =
          await res["data"]["updateTokenPair"]["refreshTokenExpiresAt"];

      await LocalDB.setString('token', YOUR_PERSONAL_ACCESS_TOKEN);
      await LocalDB.setInt('accessTokenExpiresAt', ACCESS_TOKEN_EXPIRES_AT);
      await LocalDB.setString('refreshToken', YOUR_PERSONAL_REFRESH_TOKEN);
      await LocalDB.setInt('refreshTokenExpiresAt', REFRESH_TOKEN_EXPIRES_AT);
    }
  }

  Future<Map<String, dynamic>> mutateRequest(
      DocumentNode readRepositories, Map<String, dynamic> map,
      [bool withoutToken = false]) async {
    bool networkAvailable = await LocalDB.isNetworkAvailable();
    if (networkAvailable == true) {
      final _options = MutationOptions(
        document: readRepositories,
        variables: map,
      );
      QueryResult result = withoutToken != false
          ? await _clientWithoutToken!.mutate(_options)
          : await _client!.mutate(_options);
      if (result.hasException) {
        Map<String, dynamic> response = Map<String, dynamic>();
        response['success'] = false;
        //print(result.exception);
        response['message'] = result.exception;
        return response;
      } else {
        Map<String, dynamic> response = Map<String, dynamic>();
        response['success'] = true;
        response['data'] = result.data;
        return response;
      }
    } else {
      Map<String, dynamic> response = Map<String, dynamic>();
      response['success'] = false;
      response['message'] = "No internet connection";
      return response;
    }
  }

  Future<Map<String, dynamic>> queryRequest(DocumentNode readRepositories,
      Map<String, dynamic> map, bool withoutToken) async {
    bool networkAvailable = await LocalDB.isNetworkAvailable();
    if (networkAvailable == true) {
      final _options = WatchQueryOptions(
        document: readRepositories,
        variables: map,
        pollInterval: Duration(seconds: 4),
        fetchResults: true,
      );
      QueryResult result = withoutToken != false
          ? await _clientWithoutToken!.query(_options)
          : await _client!.query(_options);

      if (result.hasException) {
        Map<String, dynamic> response = Map<String, dynamic>();
        response['success'] = false;
        //  print(result.exception);
        response['message'] = result.exception;
        return response;
      } else {
        Map<String, dynamic> response = Map<String, dynamic>();
        response['success'] = true;
        response['data'] = result.data;
        return response;
      }
    } else {
      Map<String, dynamic> response = Map<String, dynamic>();
      response['success'] = false;
      response['message'] = "No internet connection";
      return response;
    }
  }

  void setSubscription(DocumentNode readRepositories, map,
      {void Function(QueryResult)? callback}) async {
    // null is loading
    if (subscriptionStream != null) {
      return;
      // subscription = null;
    }

    final _options = SubscriptionOptions(
      document: readRepositories,
      variables: map,
    );

    subscription = _client!.subscribe(_options);
    subscriptionStream = subscription!.listen((result) {
      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      if (result.isLoading) {
        print('awaiting results');
        return;
      }
      callback!(result);
    });
    return;
  }

  void setChatSubscription(DocumentNode readRepositories, map,
      {void Function(QueryResult)? callback}) async {
    // null is loading
    if (subscriptionStreamForChat != null) {
      return;
      // subscription = null;
    }

    final _options = SubscriptionOptions(
      document: readRepositories,
      variables: map,
    );

    subscription = _client!.subscribe(_options);
    subscriptionStreamForChat = subscription!.listen((result) {
      if (result.hasException) {
        print(result.exception.toString());
        return;
      }

      if (result.isLoading) {
        print('awaiting results');
        return;
      }
      callback!(result);
    });
    return;
  }
}
