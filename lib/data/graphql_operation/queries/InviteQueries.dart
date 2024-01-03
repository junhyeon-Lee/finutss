import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InviteQueries {
  static final INVITE = gql(r'''
  query Invite($id: ID!) {
    invite(id: $id) {
      id
      to {
        ...UserFragment
      }
      created
      createdAt
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final INVITES = gql(r'''
  query Invites($findQuery: JSON) {
    invites(findQuery: $findQuery) {
      id
      to {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      createdAt
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final ADD_INVITE = gql(r'''
  mutation AddInvite($data: InputInvite) {
    addInvite(data: $data) {
      id
      to {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      createdAt
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final REMOVE_INVITE = gql(r'''
  mutation RemoveInvite($id: ID!) {
    removeInvite(id: $id)
  }
''');

  static final INVITE_PAGINATE = gql(r'''
  query InvitePaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
    $userId: ID
    $type: String
  ) {
    invitePaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
      userId: $userId
      type: $type
    ) {
      docs {
          id
          to {
            ...UserFragment
          }
          created
          createdAt
      }
      totalDocs
      limit
      page
      totalPages
      hasNextPage
      nextPage
      hasPrevPage
      prevPage
      pagingCounter
    }
  }
'''
      '''${Fragments.userFragment}''');
}
