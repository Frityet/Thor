/*
 * Thunderstore API
 *
 * Schema is automatically generated and not completely accurate.
 *
 * The version of the OpenAPI document: v1
 * 
 * Generated by: https://openapi-generator.tech
 */




#[derive(Clone, Debug, PartialEq, Default, Serialize, Deserialize)]
pub struct PackageSubmissionMetadata {
    #[serde(rename = "author_name")]
    pub author_name: String,
    #[serde(rename = "categories", skip_serializing_if = "Option::is_none")]
    pub categories: Option<Vec<String>>,
    #[serde(rename = "communities")]
    pub communities: Vec<String>,
    #[serde(rename = "has_nsfw_content")]
    pub has_nsfw_content: bool,
    #[serde(rename = "upload_uuid")]
    pub upload_uuid: uuid::Uuid,
    #[serde(rename = "community_categories", skip_serializing_if = "Option::is_none")]
    pub community_categories: Option<::std::collections::HashMap<String, Vec<String>>>,
}

impl PackageSubmissionMetadata {
    pub fn new(author_name: String, communities: Vec<String>, has_nsfw_content: bool, upload_uuid: uuid::Uuid) -> PackageSubmissionMetadata {
        PackageSubmissionMetadata {
            author_name,
            categories: None,
            communities,
            has_nsfw_content,
            upload_uuid,
            community_categories: None,
        }
    }
}


