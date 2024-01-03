import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ChatQueries {
  static final CHATTING = gql(r'''
  query Chatting($page: Int, $limit: Int, $findQuery: JSON) {
    chatting(page: $page, limit: $limit, findQuery: $findQuery) {
      docs {
        id
        command {
          type
          user {
            ...UserFragment
          }
        }
        description
        read
        writer {
          ...UserFragment
        }
        link
        extra
        createdAt
        updatedAt
      }
      totalDocs
      limit
      offset
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

  static final NEW_CHAT = gql(r'''
  subscription NewChat($chatRoom: String!) {
    newChat(chatRoom: $chatRoom) {
      id
      command {
        type
        user {
          ...UserFragment
        }
      }
      writer {
        ...UserFragment
      }
      description
      extra
      createdAt
      updatedAt
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final NEW_CHAT_ROOM = gql(r'''
  subscription NewChatRoom($userId: ID!) {
    newChatRoom(userId: $userId) {
      ...ChatRoomFragment
    }
  }
'''
      '''${Fragments.chatRoomFragment}''');

  static final WRITE_CHAT = gql(r'''
  mutation WriteChat($data: InputChat) {
    writeChat(data: $data)
  }
''');
  static final READ_CHAT = gql(r'''
  mutation ReadChat($chatRoom: ID!) {
    readChat(chatRoom: $chatRoom)
  }
''');
}
