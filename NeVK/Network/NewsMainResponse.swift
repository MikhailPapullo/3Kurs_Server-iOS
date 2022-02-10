//
//  NewsMainResponse.swift
//  NeVK
//
//  Created by Mikhail Papullo on 2/8/22.
//

import Foundation

struct NewsMainResponse: Codable {
    let response:
}

struct NewsContentResponse: Codable {
    let items: [NewsModel]
    let profiles: [InfoProfile]
    let groups: [InfoGroup]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKeys {
        case items, profiles
        case nextFrom = "next_from"
    }
}

struct InfoGroup: Codable {
    let id: Int
    let name: String
    let photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo100 = "photo_100"
    }
}

struct InfoProfile: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo50: String
    let online: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case firsctName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case online
    }
}

struct NewsModel: Codable {
    let sourceId: Int
    let date: Int
    let topicId: Int
    let text: String
    let postId: Int
    let comments: CommentsNews
    let likes: Likes?
    let views: Views?
    let reposts: RepostNews?
    let attachments: [ItemsAttachment]
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case topicId = "topic_id"
        case text
        case postId = "post_id"
        case attachments
        case comments
        case likes
        case views
    }
}

struct Likes: Codable {
    let count: Int
    let canLike: Int
    let userLikes: Int
    let canPublish: Int
    
    enum CodingKeys: String, CodingKeys {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canpublish = "can_publish"
    }
}

struct RepostNews: Codable {
    let count: Int
    let userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct ItemsAttachment: Codable {
    let photo: Photo?
    let video: Video?
}

struct Views: Codable {
    let count: Int
}

struct Video: Codable {
    let photo320: String
    
    enum CodingKeys: String, CodingKey {
        case photo320 = "photo_320"
    }
}
struct Photo: Codable {
    let id: Int
    let ownerId: Int
    let sizes: [SizePhotoNews]
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
    }
}

struct SizePhotoNews: Codable {
    let url: String
    let type: SizeType
    
    enum SizeType: String, Codable {
        
        case 1 = "1"
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}

struct CommentsNews: Codable {
    let canPost: Int
    let groupsCanPost: Bool
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
        case count
    }
}
