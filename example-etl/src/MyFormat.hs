
{-# LANGUAGE TemplateHaskell     #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RecordWildCards     #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE DeriveGeneric       #-}

module MyFormat where

import           System.Exit        (exitFailure, exitSuccess)
import           System.IO          (stderr, hPutStrLn)
import qualified Data.ByteString.Lazy.Char8 as BSL
import           System.Environment (getArgs)
import           Control.Monad      (forM_, mzero, join)
import           Control.Applicative
import           Data.Aeson.AutoType.Alternative
import           Data.Aeson(eitherDecode, Value(..), FromJSON(..), ToJSON(..),
                            pairs,
                            (.:), (.:?), (.=), object)
import           Data.Monoid((<>))
import           Data.Text (Text)
import qualified GHC.Generics

data Gildings = Gildings { 

  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON Gildings where
  parseJSON (Object v) = return  Gildings
  parseJSON _          = mzero


instance ToJSON Gildings where
  toJSON     (Gildings {}) = object []



data Oembed = Oembed { 
    oembedHeight :: (Maybe (Int:|:[(Maybe Value)])),
    oembedAuthorName :: (Maybe (Text:|:[(Maybe Value)])),
    oembedThumbnailUrl :: (Maybe (Text:|:[(Maybe Value)])),
    oembedUrl :: (Maybe (Text:|:[(Maybe Value)])),
    oembedWidth :: Int,
    oembedProviderName :: Text,
    oembedThumbnailHeight :: (Maybe (Int:|:[(Maybe Value)])),
    oembedVersion :: Text,
    oembedThumbnailWidth :: (Maybe (Int:|:[(Maybe Value)])),
    oembedHtml :: Text,
    oembedProviderUrl :: Text,
    oembedTitle :: (Maybe (Text:|:[(Maybe Value)])),
    oembedCacheAge :: (Maybe (Int:|:[(Maybe Value)])),
    oembedType :: Text,
    oembedDescription :: (Maybe (Text:|:[(Maybe Value)])),
    oembedAuthorUrl :: (Maybe (Text:|:[(Maybe Value)]))
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON Oembed where
  parseJSON (Object v) = Oembed <$> v .:? "height" <*> v .:? "author_name" <*> v .:? "thumbnail_url" <*> v .:? "url" <*> v .:  "width" <*> v .:  "provider_name" <*> v .:? "thumbnail_height" <*> v .:  "version" <*> v .:? "thumbnail_width" <*> v .:  "html" <*> v .:  "provider_url" <*> v .:? "title" <*> v .:? "cache_age" <*> v .:  "type" <*> v .:? "description" <*> v .:? "author_url"
  parseJSON _          = mzero


instance ToJSON Oembed where
  toJSON     (Oembed {..}) = object ["height" .= oembedHeight, "author_name" .= oembedAuthorName, "thumbnail_url" .= oembedThumbnailUrl, "url" .= oembedUrl, "width" .= oembedWidth, "provider_name" .= oembedProviderName, "thumbnail_height" .= oembedThumbnailHeight, "version" .= oembedVersion, "thumbnail_width" .= oembedThumbnailWidth, "html" .= oembedHtml, "provider_url" .= oembedProviderUrl, "title" .= oembedTitle, "cache_age" .= oembedCacheAge, "type" .= oembedType, "description" .= oembedDescription, "author_url" .= oembedAuthorUrl]
  toEncoding (Oembed {..}) = pairs  ("height" .= oembedHeight<>"author_name" .= oembedAuthorName<>"thumbnail_url" .= oembedThumbnailUrl<>"url" .= oembedUrl<>"width" .= oembedWidth<>"provider_name" .= oembedProviderName<>"thumbnail_height" .= oembedThumbnailHeight<>"version" .= oembedVersion<>"thumbnail_width" .= oembedThumbnailWidth<>"html" .= oembedHtml<>"provider_url" .= oembedProviderUrl<>"title" .= oembedTitle<>"cache_age" .= oembedCacheAge<>"type" .= oembedType<>"description" .= oembedDescription<>"author_url" .= oembedAuthorUrl)


data Media = Media { 
    mediaOembed :: Oembed:|:[(Maybe Value)],
    mediaType :: Text
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON Media where
  parseJSON (Object v) = Media <$> v .:  "oembed" <*> v .:  "type"
  parseJSON _          = mzero


instance ToJSON Media where
  toJSON     (Media {..}) = object ["oembed" .= mediaOembed, "type" .= mediaType]
  toEncoding (Media {..}) = pairs  ("oembed" .= mediaOembed<>"type" .= mediaType)


data SecureMediaEmbed = SecureMediaEmbed { 
    secureMediaEmbedHeight :: (Maybe (Int:|:[(Maybe Value)])),
    secureMediaEmbedMediaDomainUrl :: (Maybe (Text:|:[(Maybe Value)])),
    secureMediaEmbedScrolling :: (Maybe (Bool:|:[(Maybe Value)])),
    secureMediaEmbedWidth :: (Maybe (Int:|:[(Maybe Value)])),
    secureMediaEmbedContent :: (Maybe (Text:|:[(Maybe Value)]))
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON SecureMediaEmbed where
  parseJSON (Object v) = SecureMediaEmbed <$> v .:? "height" <*> v .:? "media_domain_url" <*> v .:? "scrolling" <*> v .:? "width" <*> v .:? "content"
  parseJSON _          = mzero


instance ToJSON SecureMediaEmbed where
  toJSON     (SecureMediaEmbed {..}) = object ["height" .= secureMediaEmbedHeight, "media_domain_url" .= secureMediaEmbedMediaDomainUrl, "scrolling" .= secureMediaEmbedScrolling, "width" .= secureMediaEmbedWidth, "content" .= secureMediaEmbedContent]
  toEncoding (SecureMediaEmbed {..}) = pairs  ("height" .= secureMediaEmbedHeight<>"media_domain_url" .= secureMediaEmbedMediaDomainUrl<>"scrolling" .= secureMediaEmbedScrolling<>"width" .= secureMediaEmbedWidth<>"content" .= secureMediaEmbedContent)


data MediaEmbed = MediaEmbed { 
    mediaEmbedHeight :: (Maybe (Int:|:[(Maybe Value)])),
    mediaEmbedScrolling :: (Maybe (Bool:|:[(Maybe Value)])),
    mediaEmbedWidth :: (Maybe (Int:|:[(Maybe Value)])),
    mediaEmbedContent :: (Maybe (Text:|:[(Maybe Value)]))
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON MediaEmbed where
  parseJSON (Object v) = MediaEmbed <$> v .:? "height" <*> v .:? "scrolling" <*> v .:? "width" <*> v .:? "content"
  parseJSON _          = mzero


instance ToJSON MediaEmbed where
  toJSON     (MediaEmbed {..}) = object ["height" .= mediaEmbedHeight, "scrolling" .= mediaEmbedScrolling, "width" .= mediaEmbedWidth, "content" .= mediaEmbedContent]
  toEncoding (MediaEmbed {..}) = pairs  ("height" .= mediaEmbedHeight<>"scrolling" .= mediaEmbedScrolling<>"width" .= mediaEmbedWidth<>"content" .= mediaEmbedContent)


data CrosspostParentListElt = CrosspostParentListElt { 
    crosspostParentListEltAllAwardings :: [(Maybe Value)],
    crosspostParentListEltApprovedAtUtc :: (Maybe Value),
    crosspostParentListEltThumbnail :: Text,
    crosspostParentListEltDistinguished :: (Maybe Value),
    crosspostParentListEltHideScore :: Bool,
    crosspostParentListEltMediaOnly :: Bool,
    crosspostParentListEltGilded :: Int,
    crosspostParentListEltAuthorFlairCssClass :: (Maybe Value),
    crosspostParentListEltAllowLiveComments :: Bool,
    crosspostParentListEltDiscussionType :: (Maybe Value),
    crosspostParentListEltSendReplies :: Bool,
    crosspostParentListEltCanModPost :: Bool,
    crosspostParentListEltModReasonTitle :: (Maybe Value),
    crosspostParentListEltLocked :: Bool,
    crosspostParentListEltLinkFlairTemplateId :: Text,
    crosspostParentListEltGildings :: Gildings,
    crosspostParentListEltLinkFlairRichtext :: [(Maybe Value)],
    crosspostParentListEltAuthorFlairType :: Text,
    crosspostParentListEltBannedAtUtc :: (Maybe Value),
    crosspostParentListEltRemovalReason :: (Maybe Value),
    crosspostParentListEltScore :: Int,
    crosspostParentListEltContestMode :: Bool,
    crosspostParentListEltLinkFlairType :: Text,
    crosspostParentListEltSuggestedSort :: (Maybe Value),
    crosspostParentListEltCreated :: Int,
    crosspostParentListEltSubredditSubscribers :: Int,
    crosspostParentListEltPinned :: Bool,
    crosspostParentListEltCategory :: (Maybe Value),
    crosspostParentListEltOver18 :: Bool,
    crosspostParentListEltAuthorFlairRichtext :: [(Maybe Value)],
    crosspostParentListEltDomain :: Text,
    crosspostParentListEltUserReports :: [(Maybe Value)],
    crosspostParentListEltUrl :: Text,
    crosspostParentListEltPermalink :: Text,
    crosspostParentListEltSelftextHtml :: (Maybe Value),
    crosspostParentListEltAuthorPatreonFlair :: Bool,
    crosspostParentListEltAuthorFullname :: Text,
    crosspostParentListEltSpoiler :: Bool,
    crosspostParentListEltBannedBy :: (Maybe Value),
    crosspostParentListEltReportReasons :: (Maybe Value),
    crosspostParentListEltStickied :: Bool,
    crosspostParentListEltSubreddit :: Text,
    crosspostParentListEltIsCrosspostable :: Bool,
    crosspostParentListEltModNote :: (Maybe Value),
    crosspostParentListEltSecureMedia :: Media,
    crosspostParentListEltModReports :: [(Maybe Value)],
    crosspostParentListEltNumReports :: (Maybe Value),
    crosspostParentListEltSubredditId :: Text,
    crosspostParentListEltMedia :: Media,
    crosspostParentListEltNumCrossposts :: Int,
    crosspostParentListEltIsVideo :: Bool,
    crosspostParentListEltLinkFlairBackgroundColor :: Text,
    crosspostParentListEltName :: Text,
    crosspostParentListEltNoFollow :: Bool,
    crosspostParentListEltLinkFlairTextColor :: Text,
    crosspostParentListEltTotalAwardsReceived :: Int,
    crosspostParentListEltApprovedBy :: (Maybe Value),
    crosspostParentListEltAuthorFlairTemplateId :: (Maybe Value),
    crosspostParentListEltClicked :: Bool,
    crosspostParentListEltHidden :: Bool,
    crosspostParentListEltIsOriginalContent :: Bool,
    crosspostParentListEltLinkFlairCssClass :: Text,
    crosspostParentListEltAuthorFlairTextColor :: (Maybe Value),
    crosspostParentListEltIsRobotIndexable :: Bool,
    crosspostParentListEltParentWhitelistStatus :: (Maybe Value),
    crosspostParentListEltAuthor :: Text,
    crosspostParentListEltId :: Text,
    crosspostParentListEltLinkFlairText :: Text,
    crosspostParentListEltCreatedUtc :: Int,
    crosspostParentListEltEdited :: Bool,
    crosspostParentListEltSaved :: Bool,
    crosspostParentListEltCanGild :: Bool,
    crosspostParentListEltContentCategories :: (Maybe Value),
    crosspostParentListEltSubredditNamePrefixed :: Text,
    crosspostParentListEltWls :: (Maybe Value),
    crosspostParentListEltSecureMediaEmbed :: SecureMediaEmbed,
    crosspostParentListEltTitle :: Text,
    crosspostParentListEltMediaEmbed :: MediaEmbed,
    crosspostParentListEltVisited :: Bool,
    crosspostParentListEltPwls :: (Maybe Value),
    crosspostParentListEltLikes :: (Maybe Value),
    crosspostParentListEltIsMeta :: Bool,
    crosspostParentListEltAuthorFlairText :: (Maybe Value),
    crosspostParentListEltIsRedditMediaDomain :: Bool,
    crosspostParentListEltQuarantine :: Bool,
    crosspostParentListEltWhitelistStatus :: (Maybe Value),
    crosspostParentListEltUps :: Int,
    crosspostParentListEltArchived :: Bool,
    crosspostParentListEltSelftext :: Text,
    crosspostParentListEltSubredditType :: Text,
    crosspostParentListEltModReasonBy :: (Maybe Value),
    crosspostParentListEltDowns :: Int,
    crosspostParentListEltNumComments :: Int,
    crosspostParentListEltViewCount :: (Maybe Value),
    crosspostParentListEltAuthorFlairBackgroundColor :: (Maybe Value),
    crosspostParentListEltIsSelf :: Bool
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON CrosspostParentListElt where
  parseJSON (Object v) = CrosspostParentListElt <$> v .:  "all_awardings" <*> v .:? "approved_at_utc" <*> v .:  "thumbnail" <*> v .:? "distinguished" <*> v .:  "hide_score" <*> v .:  "media_only" <*> v .:  "gilded" <*> v .:? "author_flair_css_class" <*> v .:  "allow_live_comments" <*> v .:? "discussion_type" <*> v .:  "send_replies" <*> v .:  "can_mod_post" <*> v .:? "mod_reason_title" <*> v .:  "locked" <*> v .:  "link_flair_template_id" <*> v .:  "gildings" <*> v .:  "link_flair_richtext" <*> v .:  "author_flair_type" <*> v .:? "banned_at_utc" <*> v .:? "removal_reason" <*> v .:  "score" <*> v .:  "contest_mode" <*> v .:  "link_flair_type" <*> v .:? "suggested_sort" <*> v .:  "created" <*> v .:  "subreddit_subscribers" <*> v .:  "pinned" <*> v .:? "category" <*> v .:  "over_18" <*> v .:  "author_flair_richtext" <*> v .:  "domain" <*> v .:  "user_reports" <*> v .:  "url" <*> v .:  "permalink" <*> v .:? "selftext_html" <*> v .:  "author_patreon_flair" <*> v .:  "author_fullname" <*> v .:  "spoiler" <*> v .:? "banned_by" <*> v .:? "report_reasons" <*> v .:  "stickied" <*> v .:  "subreddit" <*> v .:  "is_crosspostable" <*> v .:? "mod_note" <*> v .:  "secure_media" <*> v .:  "mod_reports" <*> v .:? "num_reports" <*> v .:  "subreddit_id" <*> v .:  "media" <*> v .:  "num_crossposts" <*> v .:  "is_video" <*> v .:  "link_flair_background_color" <*> v .:  "name" <*> v .:  "no_follow" <*> v .:  "link_flair_text_color" <*> v .:  "total_awards_received" <*> v .:? "approved_by" <*> v .:? "author_flair_template_id" <*> v .:  "clicked" <*> v .:  "hidden" <*> v .:  "is_original_content" <*> v .:  "link_flair_css_class" <*> v .:? "author_flair_text_color" <*> v .:  "is_robot_indexable" <*> v .:? "parent_whitelist_status" <*> v .:  "author" <*> v .:  "id" <*> v .:  "link_flair_text" <*> v .:  "created_utc" <*> v .:  "edited" <*> v .:  "saved" <*> v .:  "can_gild" <*> v .:? "content_categories" <*> v .:  "subreddit_name_prefixed" <*> v .:? "wls" <*> v .:  "secure_media_embed" <*> v .:  "title" <*> v .:  "media_embed" <*> v .:  "visited" <*> v .:? "pwls" <*> v .:? "likes" <*> v .:  "is_meta" <*> v .:? "author_flair_text" <*> v .:  "is_reddit_media_domain" <*> v .:  "quarantine" <*> v .:? "whitelist_status" <*> v .:  "ups" <*> v .:  "archived" <*> v .:  "selftext" <*> v .:  "subreddit_type" <*> v .:? "mod_reason_by" <*> v .:  "downs" <*> v .:  "num_comments" <*> v .:? "view_count" <*> v .:? "author_flair_background_color" <*> v .:  "is_self"
  parseJSON _          = mzero


instance ToJSON CrosspostParentListElt where
  toJSON     (CrosspostParentListElt {..}) = object ["all_awardings" .= crosspostParentListEltAllAwardings, "approved_at_utc" .= crosspostParentListEltApprovedAtUtc, "thumbnail" .= crosspostParentListEltThumbnail, "distinguished" .= crosspostParentListEltDistinguished, "hide_score" .= crosspostParentListEltHideScore, "media_only" .= crosspostParentListEltMediaOnly, "gilded" .= crosspostParentListEltGilded, "author_flair_css_class" .= crosspostParentListEltAuthorFlairCssClass, "allow_live_comments" .= crosspostParentListEltAllowLiveComments, "discussion_type" .= crosspostParentListEltDiscussionType, "send_replies" .= crosspostParentListEltSendReplies, "can_mod_post" .= crosspostParentListEltCanModPost, "mod_reason_title" .= crosspostParentListEltModReasonTitle, "locked" .= crosspostParentListEltLocked, "link_flair_template_id" .= crosspostParentListEltLinkFlairTemplateId, "gildings" .= crosspostParentListEltGildings, "link_flair_richtext" .= crosspostParentListEltLinkFlairRichtext, "author_flair_type" .= crosspostParentListEltAuthorFlairType, "banned_at_utc" .= crosspostParentListEltBannedAtUtc, "removal_reason" .= crosspostParentListEltRemovalReason, "score" .= crosspostParentListEltScore, "contest_mode" .= crosspostParentListEltContestMode, "link_flair_type" .= crosspostParentListEltLinkFlairType, "suggested_sort" .= crosspostParentListEltSuggestedSort, "created" .= crosspostParentListEltCreated, "subreddit_subscribers" .= crosspostParentListEltSubredditSubscribers, "pinned" .= crosspostParentListEltPinned, "category" .= crosspostParentListEltCategory, "over_18" .= crosspostParentListEltOver18, "author_flair_richtext" .= crosspostParentListEltAuthorFlairRichtext, "domain" .= crosspostParentListEltDomain, "user_reports" .= crosspostParentListEltUserReports, "url" .= crosspostParentListEltUrl, "permalink" .= crosspostParentListEltPermalink, "selftext_html" .= crosspostParentListEltSelftextHtml, "author_patreon_flair" .= crosspostParentListEltAuthorPatreonFlair, "author_fullname" .= crosspostParentListEltAuthorFullname, "spoiler" .= crosspostParentListEltSpoiler, "banned_by" .= crosspostParentListEltBannedBy, "report_reasons" .= crosspostParentListEltReportReasons, "stickied" .= crosspostParentListEltStickied, "subreddit" .= crosspostParentListEltSubreddit, "is_crosspostable" .= crosspostParentListEltIsCrosspostable, "mod_note" .= crosspostParentListEltModNote, "secure_media" .= crosspostParentListEltSecureMedia, "mod_reports" .= crosspostParentListEltModReports, "num_reports" .= crosspostParentListEltNumReports, "subreddit_id" .= crosspostParentListEltSubredditId, "media" .= crosspostParentListEltMedia, "num_crossposts" .= crosspostParentListEltNumCrossposts, "is_video" .= crosspostParentListEltIsVideo, "link_flair_background_color" .= crosspostParentListEltLinkFlairBackgroundColor, "name" .= crosspostParentListEltName, "no_follow" .= crosspostParentListEltNoFollow, "link_flair_text_color" .= crosspostParentListEltLinkFlairTextColor, "total_awards_received" .= crosspostParentListEltTotalAwardsReceived, "approved_by" .= crosspostParentListEltApprovedBy, "author_flair_template_id" .= crosspostParentListEltAuthorFlairTemplateId, "clicked" .= crosspostParentListEltClicked, "hidden" .= crosspostParentListEltHidden, "is_original_content" .= crosspostParentListEltIsOriginalContent, "link_flair_css_class" .= crosspostParentListEltLinkFlairCssClass, "author_flair_text_color" .= crosspostParentListEltAuthorFlairTextColor, "is_robot_indexable" .= crosspostParentListEltIsRobotIndexable, "parent_whitelist_status" .= crosspostParentListEltParentWhitelistStatus, "author" .= crosspostParentListEltAuthor, "id" .= crosspostParentListEltId, "link_flair_text" .= crosspostParentListEltLinkFlairText, "created_utc" .= crosspostParentListEltCreatedUtc, "edited" .= crosspostParentListEltEdited, "saved" .= crosspostParentListEltSaved, "can_gild" .= crosspostParentListEltCanGild, "content_categories" .= crosspostParentListEltContentCategories, "subreddit_name_prefixed" .= crosspostParentListEltSubredditNamePrefixed, "wls" .= crosspostParentListEltWls, "secure_media_embed" .= crosspostParentListEltSecureMediaEmbed, "title" .= crosspostParentListEltTitle, "media_embed" .= crosspostParentListEltMediaEmbed, "visited" .= crosspostParentListEltVisited, "pwls" .= crosspostParentListEltPwls, "likes" .= crosspostParentListEltLikes, "is_meta" .= crosspostParentListEltIsMeta, "author_flair_text" .= crosspostParentListEltAuthorFlairText, "is_reddit_media_domain" .= crosspostParentListEltIsRedditMediaDomain, "quarantine" .= crosspostParentListEltQuarantine, "whitelist_status" .= crosspostParentListEltWhitelistStatus, "ups" .= crosspostParentListEltUps, "archived" .= crosspostParentListEltArchived, "selftext" .= crosspostParentListEltSelftext, "subreddit_type" .= crosspostParentListEltSubredditType, "mod_reason_by" .= crosspostParentListEltModReasonBy, "downs" .= crosspostParentListEltDowns, "num_comments" .= crosspostParentListEltNumComments, "view_count" .= crosspostParentListEltViewCount, "author_flair_background_color" .= crosspostParentListEltAuthorFlairBackgroundColor, "is_self" .= crosspostParentListEltIsSelf]
  toEncoding (CrosspostParentListElt {..}) = pairs  ("all_awardings" .= crosspostParentListEltAllAwardings<>"approved_at_utc" .= crosspostParentListEltApprovedAtUtc<>"thumbnail" .= crosspostParentListEltThumbnail<>"distinguished" .= crosspostParentListEltDistinguished<>"hide_score" .= crosspostParentListEltHideScore<>"media_only" .= crosspostParentListEltMediaOnly<>"gilded" .= crosspostParentListEltGilded<>"author_flair_css_class" .= crosspostParentListEltAuthorFlairCssClass<>"allow_live_comments" .= crosspostParentListEltAllowLiveComments<>"discussion_type" .= crosspostParentListEltDiscussionType<>"send_replies" .= crosspostParentListEltSendReplies<>"can_mod_post" .= crosspostParentListEltCanModPost<>"mod_reason_title" .= crosspostParentListEltModReasonTitle<>"locked" .= crosspostParentListEltLocked<>"link_flair_template_id" .= crosspostParentListEltLinkFlairTemplateId<>"gildings" .= crosspostParentListEltGildings<>"link_flair_richtext" .= crosspostParentListEltLinkFlairRichtext<>"author_flair_type" .= crosspostParentListEltAuthorFlairType<>"banned_at_utc" .= crosspostParentListEltBannedAtUtc<>"removal_reason" .= crosspostParentListEltRemovalReason<>"score" .= crosspostParentListEltScore<>"contest_mode" .= crosspostParentListEltContestMode<>"link_flair_type" .= crosspostParentListEltLinkFlairType<>"suggested_sort" .= crosspostParentListEltSuggestedSort<>"created" .= crosspostParentListEltCreated<>"subreddit_subscribers" .= crosspostParentListEltSubredditSubscribers<>"pinned" .= crosspostParentListEltPinned<>"category" .= crosspostParentListEltCategory<>"over_18" .= crosspostParentListEltOver18<>"author_flair_richtext" .= crosspostParentListEltAuthorFlairRichtext<>"domain" .= crosspostParentListEltDomain<>"user_reports" .= crosspostParentListEltUserReports<>"url" .= crosspostParentListEltUrl<>"permalink" .= crosspostParentListEltPermalink<>"selftext_html" .= crosspostParentListEltSelftextHtml<>"author_patreon_flair" .= crosspostParentListEltAuthorPatreonFlair<>"author_fullname" .= crosspostParentListEltAuthorFullname<>"spoiler" .= crosspostParentListEltSpoiler<>"banned_by" .= crosspostParentListEltBannedBy<>"report_reasons" .= crosspostParentListEltReportReasons<>"stickied" .= crosspostParentListEltStickied<>"subreddit" .= crosspostParentListEltSubreddit<>"is_crosspostable" .= crosspostParentListEltIsCrosspostable<>"mod_note" .= crosspostParentListEltModNote<>"secure_media" .= crosspostParentListEltSecureMedia<>"mod_reports" .= crosspostParentListEltModReports<>"num_reports" .= crosspostParentListEltNumReports<>"subreddit_id" .= crosspostParentListEltSubredditId<>"media" .= crosspostParentListEltMedia<>"num_crossposts" .= crosspostParentListEltNumCrossposts<>"is_video" .= crosspostParentListEltIsVideo<>"link_flair_background_color" .= crosspostParentListEltLinkFlairBackgroundColor<>"name" .= crosspostParentListEltName<>"no_follow" .= crosspostParentListEltNoFollow<>"link_flair_text_color" .= crosspostParentListEltLinkFlairTextColor<>"total_awards_received" .= crosspostParentListEltTotalAwardsReceived<>"approved_by" .= crosspostParentListEltApprovedBy<>"author_flair_template_id" .= crosspostParentListEltAuthorFlairTemplateId<>"clicked" .= crosspostParentListEltClicked<>"hidden" .= crosspostParentListEltHidden<>"is_original_content" .= crosspostParentListEltIsOriginalContent<>"link_flair_css_class" .= crosspostParentListEltLinkFlairCssClass<>"author_flair_text_color" .= crosspostParentListEltAuthorFlairTextColor<>"is_robot_indexable" .= crosspostParentListEltIsRobotIndexable<>"parent_whitelist_status" .= crosspostParentListEltParentWhitelistStatus<>"author" .= crosspostParentListEltAuthor<>"id" .= crosspostParentListEltId<>"link_flair_text" .= crosspostParentListEltLinkFlairText<>"created_utc" .= crosspostParentListEltCreatedUtc<>"edited" .= crosspostParentListEltEdited<>"saved" .= crosspostParentListEltSaved<>"can_gild" .= crosspostParentListEltCanGild<>"content_categories" .= crosspostParentListEltContentCategories<>"subreddit_name_prefixed" .= crosspostParentListEltSubredditNamePrefixed<>"wls" .= crosspostParentListEltWls<>"secure_media_embed" .= crosspostParentListEltSecureMediaEmbed<>"title" .= crosspostParentListEltTitle<>"media_embed" .= crosspostParentListEltMediaEmbed<>"visited" .= crosspostParentListEltVisited<>"pwls" .= crosspostParentListEltPwls<>"likes" .= crosspostParentListEltLikes<>"is_meta" .= crosspostParentListEltIsMeta<>"author_flair_text" .= crosspostParentListEltAuthorFlairText<>"is_reddit_media_domain" .= crosspostParentListEltIsRedditMediaDomain<>"quarantine" .= crosspostParentListEltQuarantine<>"whitelist_status" .= crosspostParentListEltWhitelistStatus<>"ups" .= crosspostParentListEltUps<>"archived" .= crosspostParentListEltArchived<>"selftext" .= crosspostParentListEltSelftext<>"subreddit_type" .= crosspostParentListEltSubredditType<>"mod_reason_by" .= crosspostParentListEltModReasonBy<>"downs" .= crosspostParentListEltDowns<>"num_comments" .= crosspostParentListEltNumComments<>"view_count" .= crosspostParentListEltViewCount<>"author_flair_background_color" .= crosspostParentListEltAuthorFlairBackgroundColor<>"is_self" .= crosspostParentListEltIsSelf)


data Data = Data { 
    dataAfter :: (Maybe (Text:|:[(Maybe Value)])),
    dataAllAwardings :: (Maybe ([[(Maybe Value)]])),
    dataApprovedAtUtc :: (Maybe Value),
    dataThumbnail :: (Maybe (Text:|:[(Maybe Value)])),
    dataDistinguished :: (Maybe (Text:|:[(Maybe Value)])),
    dataHideScore :: (Maybe (Bool:|:[(Maybe Value)])),
    dataMediaOnly :: (Maybe (Bool:|:[(Maybe Value)])),
    dataGilded :: (Maybe (Int:|:[(Maybe Value)])),
    dataAuthorFlairCssClass :: (Maybe Value),
    dataAllowLiveComments :: (Maybe (Bool:|:[(Maybe Value)])),
    dataDiscussionType :: (Maybe Value),
    dataSendReplies :: (Maybe (Bool:|:[(Maybe Value)])),
    dataCanModPost :: (Maybe (Bool:|:[(Maybe Value)])),
    dataModReasonTitle :: (Maybe Value),
    dataLocked :: (Maybe (Bool:|:[(Maybe Value)])),
    dataGildings :: (Maybe (Gildings:|:[(Maybe Value)])),
    dataLinkFlairRichtext :: (Maybe ([[(Maybe Value)]])),
    dataAuthorFlairType :: (Maybe (Text:|:[(Maybe Value)])),
    dataBannedAtUtc :: (Maybe Value),
    dataRemovalReason :: (Maybe Value),
    dataScore :: (Maybe (Int:|:[(Maybe Value)])),
    dataContestMode :: (Maybe (Bool:|:[(Maybe Value)])),
    dataLinkFlairType :: (Maybe (Text:|:[(Maybe Value)])),
    dataSuggestedSort :: (Maybe (Text:|:[(Maybe Value)])),
    dataCreated :: (Maybe (Int:|:[(Maybe Value)])),
    dataSubredditSubscribers :: (Maybe (Int:|:[(Maybe Value)])),
    dataPinned :: (Maybe (Bool:|:[(Maybe Value)])),
    dataCategory :: (Maybe Value),
    dataOver18 :: (Maybe (Bool:|:[(Maybe Value)])),
    dataAuthorFlairRichtext :: (Maybe ([[(Maybe Value)]])),
    dataDomain :: (Maybe (Text:|:[(Maybe Value)])),
    dataUserReports :: (Maybe ([[(Maybe Value)]])),
    dataChildren :: (Maybe ([ChildrenElt])),
    dataUrl :: (Maybe (Text:|:[(Maybe Value)])),
    dataPermalink :: (Maybe (Text:|:[(Maybe Value)])),
    dataSelftextHtml :: (Maybe (Text:|:[(Maybe Value)])),
    dataAuthorPatreonFlair :: (Maybe (Bool:|:[(Maybe Value)])),
    dataAuthorFullname :: (Maybe (Text:|:[(Maybe Value)])),
    dataSpoiler :: (Maybe (Bool:|:[(Maybe Value)])),
    dataBannedBy :: (Maybe Value),
    dataReportReasons :: (Maybe Value),
    dataStickied :: (Maybe (Bool:|:[(Maybe Value)])),
    dataSubreddit :: (Maybe (Text:|:[(Maybe Value)])),
    dataIsCrosspostable :: (Maybe (Bool:|:[(Maybe Value)])),
    dataModNote :: (Maybe Value),
    dataSecureMedia :: (Maybe (Media:|:[(Maybe Value)])),
    dataModReports :: (Maybe ([[(Maybe Value)]])),
    dataNumReports :: (Maybe Value),
    dataModhash :: (Maybe (Text:|:[(Maybe Value)])),
    dataSubredditId :: (Maybe (Text:|:[(Maybe Value)])),
    dataMedia :: (Maybe (Media:|:[(Maybe Value)])),
    dataNumCrossposts :: (Maybe (Int:|:[(Maybe Value)])),
    dataIsVideo :: (Maybe (Bool:|:[(Maybe Value)])),
    dataLinkFlairBackgroundColor :: (Maybe (Text:|:[(Maybe Value)])),
    dataName :: (Maybe (Text:|:[(Maybe Value)])),
    dataNoFollow :: (Maybe (Bool:|:[(Maybe Value)])),
    dataLinkFlairTextColor :: (Maybe (Text:|:[(Maybe Value)])),
    dataTotalAwardsReceived :: (Maybe (Int:|:[(Maybe Value)])),
    dataApprovedBy :: (Maybe Value),
    dataAuthorFlairTemplateId :: (Maybe Value),
    dataClicked :: (Maybe (Bool:|:[(Maybe Value)])),
    dataDist :: (Maybe (Int:|:[(Maybe Value)])),
    dataHidden :: (Maybe (Bool:|:[(Maybe Value)])),
    dataIsOriginalContent :: (Maybe (Bool:|:[(Maybe Value)])),
    dataLinkFlairCssClass :: (Maybe Value),
    dataAuthorFlairTextColor :: (Maybe Value),
    dataIsRobotIndexable :: (Maybe (Bool:|:[(Maybe Value)])),
    dataParentWhitelistStatus :: (Maybe (Text:|:[(Maybe Value)])),
    dataCrosspostParent :: (Maybe (Text:|:[(Maybe Value)])),
    dataAuthor :: (Maybe (Text:|:[(Maybe Value)])),
    dataId :: (Maybe (Text:|:[(Maybe Value)])),
    dataLinkFlairText :: (Maybe Value),
    dataCreatedUtc :: (Maybe (Int:|:[(Maybe Value)])),
    dataEdited :: (Maybe (Bool:|:Int:|:[(Maybe Value)])),
    dataSaved :: (Maybe (Bool:|:[(Maybe Value)])),
    dataCanGild :: (Maybe (Bool:|:[(Maybe Value)])),
    dataContentCategories :: (Maybe Value),
    dataSubredditNamePrefixed :: (Maybe (Text:|:[(Maybe Value)])),
    dataWls :: (Maybe (Int:|:[(Maybe Value)])),
    dataSecureMediaEmbed :: (Maybe (SecureMediaEmbed:|:[(Maybe Value)])),
    dataTitle :: (Maybe (Text:|:[(Maybe Value)])),
    dataMediaEmbed :: (Maybe (MediaEmbed:|:[(Maybe Value)])),
    dataVisited :: (Maybe (Bool:|:[(Maybe Value)])),
    dataCrosspostParentList :: (Maybe ([CrosspostParentListElt])),
    dataPwls :: (Maybe (Int:|:[(Maybe Value)])),
    dataLikes :: (Maybe Value),
    dataIsMeta :: (Maybe (Bool:|:[(Maybe Value)])),
    dataAuthorFlairText :: (Maybe Value),
    dataIsRedditMediaDomain :: (Maybe (Bool:|:[(Maybe Value)])),
    dataQuarantine :: (Maybe (Bool:|:[(Maybe Value)])),
    dataWhitelistStatus :: (Maybe (Text:|:[(Maybe Value)])),
    dataUps :: (Maybe (Int:|:[(Maybe Value)])),
    dataArchived :: (Maybe (Bool:|:[(Maybe Value)])),
    dataSelftext :: (Maybe (Text:|:[(Maybe Value)])),
    dataSubredditType :: (Maybe (Text:|:[(Maybe Value)])),
    dataModReasonBy :: (Maybe Value),
    dataBefore :: (Maybe Value),
    dataDowns :: (Maybe (Int:|:[(Maybe Value)])),
    dataNumComments :: (Maybe (Int:|:[(Maybe Value)])),
    dataViewCount :: (Maybe Value),
    dataAuthorFlairBackgroundColor :: (Maybe Value),
    dataIsSelf :: (Maybe (Bool:|:[(Maybe Value)]))
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON Data where
  parseJSON (Object v) = Data <$> v .:? "after" <*> v .:? "all_awardings" <*> v .:? "approved_at_utc" <*> v .:? "thumbnail" <*> v .:? "distinguished" <*> v .:? "hide_score" <*> v .:? "media_only" <*> v .:? "gilded" <*> v .:? "author_flair_css_class" <*> v .:? "allow_live_comments" <*> v .:? "discussion_type" <*> v .:? "send_replies" <*> v .:? "can_mod_post" <*> v .:? "mod_reason_title" <*> v .:? "locked" <*> v .:? "gildings" <*> v .:? "link_flair_richtext" <*> v .:? "author_flair_type" <*> v .:? "banned_at_utc" <*> v .:? "removal_reason" <*> v .:? "score" <*> v .:? "contest_mode" <*> v .:? "link_flair_type" <*> v .:? "suggested_sort" <*> v .:? "created" <*> v .:? "subreddit_subscribers" <*> v .:? "pinned" <*> v .:? "category" <*> v .:? "over_18" <*> v .:? "author_flair_richtext" <*> v .:? "domain" <*> v .:? "user_reports" <*> v .:? "children" <*> v .:? "url" <*> v .:? "permalink" <*> v .:? "selftext_html" <*> v .:? "author_patreon_flair" <*> v .:? "author_fullname" <*> v .:? "spoiler" <*> v .:? "banned_by" <*> v .:? "report_reasons" <*> v .:? "stickied" <*> v .:? "subreddit" <*> v .:? "is_crosspostable" <*> v .:? "mod_note" <*> v .:? "secure_media" <*> v .:? "mod_reports" <*> v .:? "num_reports" <*> v .:? "modhash" <*> v .:? "subreddit_id" <*> v .:? "media" <*> v .:? "num_crossposts" <*> v .:? "is_video" <*> v .:? "link_flair_background_color" <*> v .:? "name" <*> v .:? "no_follow" <*> v .:? "link_flair_text_color" <*> v .:? "total_awards_received" <*> v .:? "approved_by" <*> v .:? "author_flair_template_id" <*> v .:? "clicked" <*> v .:? "dist" <*> v .:? "hidden" <*> v .:? "is_original_content" <*> v .:? "link_flair_css_class" <*> v .:? "author_flair_text_color" <*> v .:? "is_robot_indexable" <*> v .:? "parent_whitelist_status" <*> v .:? "crosspost_parent" <*> v .:? "author" <*> v .:? "id" <*> v .:? "link_flair_text" <*> v .:? "created_utc" <*> v .:? "edited" <*> v .:? "saved" <*> v .:? "can_gild" <*> v .:? "content_categories" <*> v .:? "subreddit_name_prefixed" <*> v .:? "wls" <*> v .:? "secure_media_embed" <*> v .:? "title" <*> v .:? "media_embed" <*> v .:? "visited" <*> v .:? "crosspost_parent_list" <*> v .:? "pwls" <*> v .:? "likes" <*> v .:? "is_meta" <*> v .:? "author_flair_text" <*> v .:? "is_reddit_media_domain" <*> v .:? "quarantine" <*> v .:? "whitelist_status" <*> v .:? "ups" <*> v .:? "archived" <*> v .:? "selftext" <*> v .:? "subreddit_type" <*> v .:? "mod_reason_by" <*> v .:? "before" <*> v .:? "downs" <*> v .:? "num_comments" <*> v .:? "view_count" <*> v .:? "author_flair_background_color" <*> v .:? "is_self"
  parseJSON _          = mzero


instance ToJSON Data where
  toJSON     (Data {..}) = object ["after" .= dataAfter, "all_awardings" .= dataAllAwardings, "approved_at_utc" .= dataApprovedAtUtc, "thumbnail" .= dataThumbnail, "distinguished" .= dataDistinguished, "hide_score" .= dataHideScore, "media_only" .= dataMediaOnly, "gilded" .= dataGilded, "author_flair_css_class" .= dataAuthorFlairCssClass, "allow_live_comments" .= dataAllowLiveComments, "discussion_type" .= dataDiscussionType, "send_replies" .= dataSendReplies, "can_mod_post" .= dataCanModPost, "mod_reason_title" .= dataModReasonTitle, "locked" .= dataLocked, "gildings" .= dataGildings, "link_flair_richtext" .= dataLinkFlairRichtext, "author_flair_type" .= dataAuthorFlairType, "banned_at_utc" .= dataBannedAtUtc, "removal_reason" .= dataRemovalReason, "score" .= dataScore, "contest_mode" .= dataContestMode, "link_flair_type" .= dataLinkFlairType, "suggested_sort" .= dataSuggestedSort, "created" .= dataCreated, "subreddit_subscribers" .= dataSubredditSubscribers, "pinned" .= dataPinned, "category" .= dataCategory, "over_18" .= dataOver18, "author_flair_richtext" .= dataAuthorFlairRichtext, "domain" .= dataDomain, "user_reports" .= dataUserReports, "children" .= dataChildren, "url" .= dataUrl, "permalink" .= dataPermalink, "selftext_html" .= dataSelftextHtml, "author_patreon_flair" .= dataAuthorPatreonFlair, "author_fullname" .= dataAuthorFullname, "spoiler" .= dataSpoiler, "banned_by" .= dataBannedBy, "report_reasons" .= dataReportReasons, "stickied" .= dataStickied, "subreddit" .= dataSubreddit, "is_crosspostable" .= dataIsCrosspostable, "mod_note" .= dataModNote, "secure_media" .= dataSecureMedia, "mod_reports" .= dataModReports, "num_reports" .= dataNumReports, "modhash" .= dataModhash, "subreddit_id" .= dataSubredditId, "media" .= dataMedia, "num_crossposts" .= dataNumCrossposts, "is_video" .= dataIsVideo, "link_flair_background_color" .= dataLinkFlairBackgroundColor, "name" .= dataName, "no_follow" .= dataNoFollow, "link_flair_text_color" .= dataLinkFlairTextColor, "total_awards_received" .= dataTotalAwardsReceived, "approved_by" .= dataApprovedBy, "author_flair_template_id" .= dataAuthorFlairTemplateId, "clicked" .= dataClicked, "dist" .= dataDist, "hidden" .= dataHidden, "is_original_content" .= dataIsOriginalContent, "link_flair_css_class" .= dataLinkFlairCssClass, "author_flair_text_color" .= dataAuthorFlairTextColor, "is_robot_indexable" .= dataIsRobotIndexable, "parent_whitelist_status" .= dataParentWhitelistStatus, "crosspost_parent" .= dataCrosspostParent, "author" .= dataAuthor, "id" .= dataId, "link_flair_text" .= dataLinkFlairText, "created_utc" .= dataCreatedUtc, "edited" .= dataEdited, "saved" .= dataSaved, "can_gild" .= dataCanGild, "content_categories" .= dataContentCategories, "subreddit_name_prefixed" .= dataSubredditNamePrefixed, "wls" .= dataWls, "secure_media_embed" .= dataSecureMediaEmbed, "title" .= dataTitle, "media_embed" .= dataMediaEmbed, "visited" .= dataVisited, "crosspost_parent_list" .= dataCrosspostParentList, "pwls" .= dataPwls, "likes" .= dataLikes, "is_meta" .= dataIsMeta, "author_flair_text" .= dataAuthorFlairText, "is_reddit_media_domain" .= dataIsRedditMediaDomain, "quarantine" .= dataQuarantine, "whitelist_status" .= dataWhitelistStatus, "ups" .= dataUps, "archived" .= dataArchived, "selftext" .= dataSelftext, "subreddit_type" .= dataSubredditType, "mod_reason_by" .= dataModReasonBy, "before" .= dataBefore, "downs" .= dataDowns, "num_comments" .= dataNumComments, "view_count" .= dataViewCount, "author_flair_background_color" .= dataAuthorFlairBackgroundColor, "is_self" .= dataIsSelf]
  toEncoding (Data {..}) = pairs  ("after" .= dataAfter<>"all_awardings" .= dataAllAwardings<>"approved_at_utc" .= dataApprovedAtUtc<>"thumbnail" .= dataThumbnail<>"distinguished" .= dataDistinguished<>"hide_score" .= dataHideScore<>"media_only" .= dataMediaOnly<>"gilded" .= dataGilded<>"author_flair_css_class" .= dataAuthorFlairCssClass<>"allow_live_comments" .= dataAllowLiveComments<>"discussion_type" .= dataDiscussionType<>"send_replies" .= dataSendReplies<>"can_mod_post" .= dataCanModPost<>"mod_reason_title" .= dataModReasonTitle<>"locked" .= dataLocked<>"gildings" .= dataGildings<>"link_flair_richtext" .= dataLinkFlairRichtext<>"author_flair_type" .= dataAuthorFlairType<>"banned_at_utc" .= dataBannedAtUtc<>"removal_reason" .= dataRemovalReason<>"score" .= dataScore<>"contest_mode" .= dataContestMode<>"link_flair_type" .= dataLinkFlairType<>"suggested_sort" .= dataSuggestedSort<>"created" .= dataCreated<>"subreddit_subscribers" .= dataSubredditSubscribers<>"pinned" .= dataPinned<>"category" .= dataCategory<>"over_18" .= dataOver18<>"author_flair_richtext" .= dataAuthorFlairRichtext<>"domain" .= dataDomain<>"user_reports" .= dataUserReports<>"children" .= dataChildren<>"url" .= dataUrl<>"permalink" .= dataPermalink<>"selftext_html" .= dataSelftextHtml<>"author_patreon_flair" .= dataAuthorPatreonFlair<>"author_fullname" .= dataAuthorFullname<>"spoiler" .= dataSpoiler<>"banned_by" .= dataBannedBy<>"report_reasons" .= dataReportReasons<>"stickied" .= dataStickied<>"subreddit" .= dataSubreddit<>"is_crosspostable" .= dataIsCrosspostable<>"mod_note" .= dataModNote<>"secure_media" .= dataSecureMedia<>"mod_reports" .= dataModReports<>"num_reports" .= dataNumReports<>"modhash" .= dataModhash<>"subreddit_id" .= dataSubredditId<>"media" .= dataMedia<>"num_crossposts" .= dataNumCrossposts<>"is_video" .= dataIsVideo<>"link_flair_background_color" .= dataLinkFlairBackgroundColor<>"name" .= dataName<>"no_follow" .= dataNoFollow<>"link_flair_text_color" .= dataLinkFlairTextColor<>"total_awards_received" .= dataTotalAwardsReceived<>"approved_by" .= dataApprovedBy<>"author_flair_template_id" .= dataAuthorFlairTemplateId<>"clicked" .= dataClicked<>"dist" .= dataDist<>"hidden" .= dataHidden<>"is_original_content" .= dataIsOriginalContent<>"link_flair_css_class" .= dataLinkFlairCssClass<>"author_flair_text_color" .= dataAuthorFlairTextColor<>"is_robot_indexable" .= dataIsRobotIndexable<>"parent_whitelist_status" .= dataParentWhitelistStatus<>"crosspost_parent" .= dataCrosspostParent<>"author" .= dataAuthor<>"id" .= dataId<>"link_flair_text" .= dataLinkFlairText<>"created_utc" .= dataCreatedUtc<>"edited" .= dataEdited<>"saved" .= dataSaved<>"can_gild" .= dataCanGild<>"content_categories" .= dataContentCategories<>"subreddit_name_prefixed" .= dataSubredditNamePrefixed<>"wls" .= dataWls<>"secure_media_embed" .= dataSecureMediaEmbed<>"title" .= dataTitle<>"media_embed" .= dataMediaEmbed<>"visited" .= dataVisited<>"crosspost_parent_list" .= dataCrosspostParentList<>"pwls" .= dataPwls<>"likes" .= dataLikes<>"is_meta" .= dataIsMeta<>"author_flair_text" .= dataAuthorFlairText<>"is_reddit_media_domain" .= dataIsRedditMediaDomain<>"quarantine" .= dataQuarantine<>"whitelist_status" .= dataWhitelistStatus<>"ups" .= dataUps<>"archived" .= dataArchived<>"selftext" .= dataSelftext<>"subreddit_type" .= dataSubredditType<>"mod_reason_by" .= dataModReasonBy<>"before" .= dataBefore<>"downs" .= dataDowns<>"num_comments" .= dataNumComments<>"view_count" .= dataViewCount<>"author_flair_background_color" .= dataAuthorFlairBackgroundColor<>"is_self" .= dataIsSelf)


data ChildrenElt = ChildrenElt { 
    childrenEltKind :: Text,
    childrenEltData :: Data:|:[(Maybe Value)]
  } deriving (Show,Eq,GHC.Generics.Generic)


instance FromJSON ChildrenElt where
  parseJSON (Object v) = ChildrenElt <$> v .:  "kind" <*> v .:  "data"
  parseJSON _          = mzero


instance ToJSON ChildrenElt where
  toJSON     (ChildrenElt {..}) = object ["kind" .= childrenEltKind, "data" .= childrenEltData]
  toEncoding (ChildrenElt {..}) = pairs  ("kind" .= childrenEltKind<>"data" .= childrenEltData)




parse :: FilePath -> IO TopLevel
parse filename = do
    input <- BSL.readFile filename
    case eitherDecode input of
      Left  err -> fatal $ case (eitherDecode input :: Either String Value) of
                           Left  err -> "Invalid JSON file: " ++ filename ++ " ++ err"
                           Right _   -> "Mismatched JSON value from file: " ++ filename
                                     ++ "\n" ++ err
      Right r   -> return (r :: TopLevel)
  where
    fatal :: String -> IO a
    fatal msg = do hPutStrLn stderr msg
                   exitFailure

main :: IO ()
main = do
  filenames <- getArgs
  forM_ filenames (\f -> parse f >>= (\p -> p `seq` putStrLn $ "Successfully parsed " ++ f))
  exitSuccess

