import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BlockQueries {
  static final BLOCK = gql(r'''
  query Block($id: ID!) {
    block(id: $id) {
      ...BlockFragment
    }
  }
'''
      '''${Fragments.blockFragment}''');

  static final BLOCKS = gql(r'''
  query Blocks($findQuery: JSON) {
    blocks(findQuery: $findQuery) {
      ...BlockFragment
    }
  }
'''
      '''${Fragments.blockFragment}''');

  static final ADD_BLOCK = gql(r'''
  mutation AddBlock($data: InputBlock) {
    addBlock(data: $data) {
      ...BlockFragment
    }
  }
'''
      '''${Fragments.blockFragment}''');

  static final UPDATE_BLOCK = gql(r'''
  mutation UpdateBlock($id: ID!, $data: InputBlock) {
    updateBlock(id: $id, data: $data) {
      ...BlockFragment
    }
  }
'''
      '''${Fragments.blockFragment}''');

  static final REMOVE_BLOCK = gql(r'''
  mutation RemoveBlock($id: ID!) {
    removeBlock(id: $id)
  }
''');

  static final BLOCK_PAGINATE = gql(r'''
  query BlockPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    blockPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...BlockFragment
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
      '''${Fragments.blockFragment}''');
}
