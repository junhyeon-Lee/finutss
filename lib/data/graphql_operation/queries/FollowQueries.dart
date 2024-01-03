import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FollowQueries {
  static final FOLLOW_USER = gql(r'''
  mutation($value: Boolean!, $followId: Int!) {
    followUser(value: $value, followId: $followId)
  }
''');

  static final GET_FOLLOWERS_USERS = gql(r'''
  query {
    getFollowers {
    ...UserFragment
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final GET_FOLLOWING_USERS = gql(r'''
  query {
    getFollowing {
    ...UserFragment
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final GET_FOLLOWERS_COUNT = gql(r'''
  query  {
  getFollowersCount
}
''');

  static final GET_FOLLOWING_COUNT = gql(r'''
  query {
    getFollowingCount
  }
''');
}
