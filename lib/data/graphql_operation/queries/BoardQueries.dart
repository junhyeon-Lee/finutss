import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BoardQueries {
  static final BOARDS = gql(r'''
  query Boards($isAdmin: Boolean, $findQuery: JSON) {
    boards(isAdmin: $isAdmin, findQuery: $findQuery) {
      ...BoardFragment
    }
  }
'''
      '''${Fragments.boardFragment}''');

  static final ADD_BOARD = gql(r'''
  ${boardFragment}
  mutation AddBoard($data: InputBoard) {
    addBoard(data: $data) {
      ...BoardFragment
    }
  }
'''
      '''${Fragments.boardFragment}''');

  static final UPDATE_BOARD = gql(r'''
  ${boardFragment}
  mutation UpdateBoard($id: ID!, $data: InputBoard) {
    updateBoard(id: $id, data: $data) {
      ...BoardFragment
    }
  }
'''
      '''${Fragments.boardFragment}''');

  static final REMOVE_BOARD = gql(r'''
  mutation RemoveBoard($id: ID!) {
    removeBoard(id: $id)
  }
'''
      '''${Fragments.boardFragment}''');
}
