import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// const String readRepositories = r'''
//   query ReadRepositories($nRepositories: Int!) {
//     viewer {
//       repositories(last: $nRepositories) {
//         nodes {
//           __typename
//           id
//           name
//           viewerHasStarred
//         }
//       }
//     }
//   }
// ''';
class Queries {
  static final readRepositories = gql(r'''
  query Users($sort: JSON, $findQuery: JSON) {
    users(sort: $sort, findQuery: $findQuery) {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '${Fragments.userFragment}');

  static final testSubscription = gql(r'''
        subscription test {
          deviceChanged(id: 2) {
            id
            name
          }
        }
    ''');
}

const String searchRepositories = r'''
  query SearchRepositories($nRepositories: Int!, $query: String!, $cursor: String) {
    search(last: $nRepositories, query: $query, type: REPOSITORY, after: $cursor) {
      nodes {
        __typename
        ... on Repository {
          name
          shortDescriptionHTML
          viewerHasStarred
          stargazers {
            totalCount
          }
          forks {
            totalCount
          }
          updatedAt
        }
      }
      pageInfo {
        endCursor
        hasNextPage
      }
    }
  }
''';
