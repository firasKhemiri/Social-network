// import 'package:graphql/client.dart';
// import '../../env.dart';

// class GraphQLService {
//   GraphQLService(String? token) {
//     Link _link;
//     final _httpLink = HttpLink(
//       Env.uri,
//     );

//     if (token != null) {
//       final authLink = AuthLink(
//         getToken: () => 'JWT $token',
//       );

//       _link = authLink.concat(_httpLink);
//     } else {
//       _link = _httpLink;
//     }

//     final policies = Policies(
//       fetch: FetchPolicy.networkOnly,
//     );

//     _client = GraphQLClient(
//         link: _link,
//         cache: GraphQLCache(store: HiveStore()),
//         defaultPolicies: DefaultPolicies(
//           watchQuery: policies,
//           query: policies,
//           mutate: policies,
//         ));
//   }

//   late GraphQLClient _client;
//   // late GraphQLClient _clientWithCache;

//   Future<QueryResult> performQuery(String query,
//       {Map<String, dynamic>? variables}) async {
//     var options = QueryOptions(document: gql(query));
//     final result = await _client.query(options);
//     return result;
//   }

//   // Future<QueryResult> performQueryWithCache(String query,
//   //     {Map<String, dynamic>? variables}) async {
//   //   var options = QueryOptions(document: gql(query));
//   //   final result = await _clientWithCache.query(options);
//   //   return result;
//   // }

//   Future<QueryResult> performMutation(String query) async {
//     var options = MutationOptions(document: gql(query));
//     final result = await _client.mutate(options);

//     // log("mutation: $query  ${result.data.toString()}");
//     return result;
//   }
// }

import 'dart:developer';

import 'package:graphql/client.dart';

import '../../env.dart';

class GraphQLService {
  GraphQLService(String? token) {
    var link = HttpLink(
      headers: <String, String>{
        'Authorization': 'JWT $token',
        'Content-Type': 'application/json'
      },
      uri: Env.uri,
    );
    _client = GraphQLClient(link: link, cache: InMemoryCache());
  }

  late GraphQLClient _client;

  Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    var options = QueryOptions(documentNode: gql(query));
    final result = await _client.query(options);

    // log("$query  ${await _client.query(options).then((value) => value.data.toString())}");
    return result;
  }

  Future<QueryResult> performMutation(String query) async {
    var options = MutationOptions(documentNode: gql(query));
    final result = await _client.mutate(options);

    // log("mutation: $query  ${result.data.toString()}");
    return result;
  }
}
