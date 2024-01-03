import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SocialQueries {
  static final SOCIAL = gql(r'''
  query Social($id: ID!) {
    social(id: $id) {
      ...SocialFragment
    }
  }
'''
      '''${Fragments.socialFragment}''');

  static final SOCIALS = gql(r'''
  query Socials($findQuery: JSON) {
    socials(findQuery: $findQuery) {
      ...SocialFragment
    }
  }
'''
      '''${Fragments.socialFragment}''');

  static final ADD_SOCIAL = gql(r'''
  mutation AddSocial($data: InputSocial) {
    addSocial(data: $data) {
      ...SocialFragment
    }
  }
'''
      '''${Fragments.socialFragment}''');

  static final UPDATE_SOCIAL = gql(r'''
  mutation UpdateSocial($id: ID!, $data: InputSocial) {
    updateSocial(id: $id, data: $data) {
      ...SocialFragment
    }
  }
'''
      '''${Fragments.socialFragment}''');

  static final REMOVE_SOCIAL = gql(r'''
  mutation RemoveSocial($id: ID!) {
    removeSocial(id: $id)
  }
''');

  static final SOCIAL_PAGINATE = gql(r'''
  query SocialPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
    $userId: ID
    $type: String
  ) {
    socialPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
      userId: $userId
      type: $type
    ) {
      docs {
       ...SocialFragment
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
      '''${Fragments.socialFragment}''');
}
