-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    bio TEXT,
    profile_picture VARCHAR(255),
    account_creation DATETIME DEFAULT CURRENT_TIMESTAMP,
    account_status ENUM('active', 'suspended'),
    is_verified BOOLEAN DEFAULT 0,
    is_private BOOLEAN DEFAULT 0,
    user_role ENUM('user', 'admin', 'moderator', 'advertiser') DEFAULT 'user', 
    social_influence INT DEFAULT 0
);

-- Posts Table
CREATE TABLE Posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    caption TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    location VARCHAR(255),
    media_url VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Likes & Reactions Table
CREATE TABLE LikesReactions (
    reaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    reaction_type ENUM('like', 'love', 'wow', 'sad'),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Comments Table
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    comment_text TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    language VARCHAR(50) DEFAULT 'en',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Replies Table
CREATE TABLE Replies (
    reply_id INT PRIMARY KEY AUTO_INCREMENT,
    comment_id INT,
    user_id INT,
    reply_text TEXT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    language VARCHAR(50) DEFAULT 'en',
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Followers Table
CREATE TABLE Followers (
    follower_id INT,
    followed_id INT,
    start_follow_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    unfollow_date DATETIME NULL,
    request_status ENUM('pending', 'accepted', 'rejected'),
    FOREIGN KEY (follower_id) REFERENCES Users(user_id),
    FOREIGN KEY (followed_id) REFERENCES Users(user_id)
);

-- Direct Messages Table
CREATE TABLE DirectMessages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT,
    receiver_id INT,
    thread_id INT,
    message_text TEXT,
    media_url VARCHAR(255),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_disappearing BOOLEAN DEFAULT 0,
    is_unsent BOOLEAN DEFAULT 0,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);

-- Stories Table
CREATE TABLE Stories (
    story_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    media_url VARCHAR(255),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_archived BOOLEAN DEFAULT 0,
    has_polls BOOLEAN DEFAULT 0, 
    has_reactions BOOLEAN DEFAULT 0, 
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Hashtags Table
CREATE TABLE Hashtags (
    hashtag_id INT PRIMARY KEY AUTO_INCREMENT,
    hashtag_text VARCHAR(50) UNIQUE
);

-- PostHashtags Table
CREATE TABLE PostHashtags (
    post_id INT,
    hashtag_id INT,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id),
    FOREIGN KEY (hashtag_id) REFERENCES Hashtags(hashtag_id)
);

-- Notifications Table
CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    is_read BOOLEAN DEFAULT 0,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Saved Posts Table
CREATE TABLE SavedPosts (
    save_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    folder_name VARCHAR(100),
    save_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    post_id INT,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Reports Table
CREATE TABLE Reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    reported_user_id INT,
    reporter_user_id INT,
    reason VARCHAR(255),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reported_user_id) REFERENCES Users(user_id),
    FOREIGN KEY (reporter_user_id) REFERENCES Users(user_id)
);

-- Analytics Table
CREATE TABLE Analytics (
    analytics_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    views INT,
    likes INT,
    comments INT,
    reach INT,
    impressions INT,
    shares INT, 
    engagement INT, 
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- Ads Table (New for Ad Campaigns)
CREATE TABLE Ads (
    ad_id INT PRIMARY KEY AUTO_INCREMENT,
    advertiser_id INT,
    post_id INT,
    campaign_name VARCHAR(100),
    budget DECIMAL(10, 2),
    start_date DATETIME,
    end_date DATETIME,
    impressions INT,
    clicks INT,
    FOREIGN KEY (advertiser_id) REFERENCES Users(user_id),
    FOREIGN KEY (post_id) REFERENCES Posts(post_id)
);

-- User Activity Log Table (New)
CREATE TABLE UserActivityLog (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    activity_type ENUM('login', 'post_interaction', 'follow', 'like', 'comment'),
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);