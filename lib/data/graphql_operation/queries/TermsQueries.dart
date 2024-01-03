import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TermsQueries {
  static final TERMS = gql(r'''
  query Terms {
    terms {
      ...TermsFragment
    }
  }
'''
      '''${Fragments.termsFragment}''');

  static final ADD_TERMS = gql(r'''
  mutation AddTerms($data: InputTerms) {
    addTerms(data: $data) {
      ...TermsFragment
    }
  }
'''
      '''${Fragments.termsFragment}''');

  static final UPDATE_TERMS = gql(r'''
  mutation UpdateTerms($id: ID!, $data: InputTerms) {
    updateTerms(id: $id, data: $data) {
      ...TermsFragment
    }
  }
'''
      '''${Fragments.termsFragment}''');
}
