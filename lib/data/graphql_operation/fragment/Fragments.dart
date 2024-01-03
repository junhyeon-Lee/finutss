class Fragments {
  static final String userFragment = '''
    fragment UserFragment on User {
      user_id
      firstname
      lastname
      username
      status
      biography
      email
      image {
            src
      }
      email_verified_at
      phone_number
      role
      created_at
      updated_at
    }
  ''';
  static final String userDetailFragment = '''
    fragment UserDetailFragment on UserDetail {
      user_detail_id
      user_id
      sex
      weight
      height
      bmr
    }
  ''';

  static final String imageFragment = '''
    fragment ImageFragment on Image {
      uid
      status
      name
      url
    }
  ''';

  static final String fileFragment = '''
    fragment FileFragment on File {
      uid
      status
      name
      url
      filename
      size
    }
  ''';

  static final noticeFragment = '''
    $imageFragment
    fragment NoticeFragment on Notice {
      id
      category
      subCategory
      qnaCategory
      status
      name
      content
      link
      images {
        ...ImageFragment
      }
      createdAt
      updatedAt
    }
  ''';
  static final reasonReportFragment = '''
    $imageFragment
    fragment ReasonReportFragment on Notice {
      id
      type
      content
      created
      createdAt
    }
  ''';

  static final blockFragment = '''
    $userFragment
    fragment BlockFragment on Block {
      id
      name
      content
      targetId {
        ...UserFragment
      }
      createdAt
      updatedAt
    }
  ''';

  static final trackFragment = '''
    $userFragment
    fragment TrackFragment on Track {
      id
      gpx
      geojson
      title
      sName
      eName
      description
      kcal
      distance
      duration
      dayOfTheWeek
      image {
        ...ImageFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
      createdAt
      updatedAt
    }
  ''';

  static final socialFragment = '''
  $userFragment
  fragment SocialFragment on Social {
    id
    users {
      ...UserFragment
    }
    follow {
      ...UserFragment
    }
    isInvite
    updated 
    createdAt
    updatedAt
  }
''';
  static final reportFragment = '''
  $imageFragment
  fragment ReportFragment on Report {
    id
    name
    link
    category
    subCategory
    content
    images {
      ...ImageFragment
    }
    createdAt
    updatedAt
  }
''';
  static final consultFragment = '''
  $imageFragment
  fragment ConsultFragment on Consult {
    id
    image {
      ...ImageFragment
    }
    category
    url
    status
    priority
    created
    updated
    createdAt
    updatedAt
  }
''';
  static final adFragment = '''
  $imageFragment
  fragment AdFragment on Ad {
    id
    image {
      ...ImageFragment
    }
    category
    url
    status
    priority
    created
    updated
    createdAt
    updatedAt
  }
''';
  static final noticeBannerFragment = '''
  $imageFragment
  fragment NoticeBannerFragment on NoticeBanner {
    id
    sourcing {
      ...ImageFragment
    }
    expert {
      ...ImageFragment
    }
    info {
      ...ImageFragment
    }
    created
    updated
    createdAt
    updatedAt
  }
''';
  static final termsFragment = '''
  $imageFragment
  fragment TermsFragment on Terms {
    id
    privatePolicy {
      content
      images {
        ...ImageFragment
      }
    }
    termOfUse {
      content
      images {
        ...ImageFragment
      }
    }
    receiveMarketInfo {
      content
      images {
        ...ImageFragment
      }
    }
    created
    updated
    createdAt
    updatedAt
  }
''';

  static final boardFragment = '''
  $userFragment
  fragment BoardFragment on Board {
    id
    name
    categories
    order
    isActivated
    createdAt
    updatedAt
    created {
      ...UserFragment
    }
    updated {
      ...UserFragment
    }
  }
''';

  static final commentFragment = '''
  $userFragment
  fragment CommentFragment on Comment {
    id
    content    

    parent
    notice
    
    createdAt
    updatedAt
    
    created {
      ...UserFragment
    }
  }
''';

  static final likeFragment = '''
  $userFragment
  fragment CommentFragment on Comment {
    id
    parent

    created {
      ...UserFragment
    }
    updated {
      ...UserFragment
    }
    createdAt
    updatedAt
  }
''';
  static final postFragment = '''
  $boardFragment
  $imageFragment
  $commentFragment
  $userFragment
  fragment PostFragment on Post {
    id
    category
    title
    content
    views
    isPopup
    images {
      ...ImageFragment
    }
    comments {
      ...CommentFragment
    }
    board {
      ...BoardFragment
    }
    parent
    createdAt
    updatedAt
    created {
      ...UserFragment
    }
    updated {
      ...UserFragment
    }
  }
''';
  static final workOutFragment = '''
  $imageFragment
  fragment WorkOutFragment on WorkOut {
    id
    description
    phase
    kcal
    distance
    duration
    maxSpeed
    finish
    createdAt
    workoutType
    writer {
      id
      nickName
      image {
        ...ImageFragment
      }
    }
    track {
      id
      gpx
      geojson
      title
      sName
      eName
      description
      kcal
      distance
      duration
      dayOfTheWeek
      image {
        ...ImageFragment
      }
    }
  }
''';
  static final chatRoomFragment = '''
  $userFragment
  fragment ChatRoomFragment on ChatRoom {
    id
    title
    description
    type
    lastChat {
        id
        command {
          type
          user {
            ...UserFragment
          }
        }
        read
        description
        writer {
          ...UserFragment
        }
        link
        extra
        createdAt
        updatedAt
      }
    userGroup
    center

    users {
        alarm
        userId {
          ...UserFragment
        }
    }

    createdAt
    updatedAt

    created {
      ...UserFragment
    }
    updated {
      ...UserFragment
    }
  }
''';
}
