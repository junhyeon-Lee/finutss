import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ADQueries {
  static final AD = gql(r'''
  query Ad($id: ID!) {
    ad(id: $id) {
      ...AdFragment
    }
  }
'''
      '''${Fragments.adFragment}''');

  static final ADS = gql(r'''
  query {
    getAds {
        ad_id
        title
        description
        content_src
        url
        status
        priority
        user_id
        created_at
        updated_at
    }
  }
''');

  static final ADD_AD = gql(r'''
  mutation AddAd($data: InputAd) {
    addAd(data: $data) {
      ...AdFragment
    }
  }
'''
      '''${Fragments.adFragment}''');

  static final UPDATE_AD = gql(r'''
  mutation UpdateAd($id: ID!, $data: InputAd) {
    updateAd(id: $id, data: $data) {
      ...AdFragment
    }
  }
'''
      '''${Fragments.adFragment}''');

  static final REMOVE_AD = gql(r'''
  mutation RemoveAd($id: ID!) {
    removeAd(id: $id)
  }
''');

  static final AD_PAGINATE = gql(r'''
  query AdPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    adPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...AdFragment
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
      '''${Fragments.adFragment}''');
}
