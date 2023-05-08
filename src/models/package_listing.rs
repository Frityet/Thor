use serde::*;
use serde_derive::{Serialize, Deserialize};
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
pub struct PackageListing {
    #[serde(rename = "name", skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    #[serde(rename = "full_name", skip_serializing_if = "Option::is_none")]
    pub full_name: Option<String>,
    #[serde(rename = "owner", skip_serializing_if = "Option::is_none")]
    pub owner: Option<String>,
    #[serde(rename = "package_url", skip_serializing_if = "Option::is_none")]
    pub package_url: Option<String>,
    #[serde(rename = "donation_link", skip_serializing_if = "Option::is_none")]
    pub donation_link: Option<String>,
    #[serde(rename = "date_created", skip_serializing_if = "Option::is_none")]
    pub date_created: Option<String>,
    #[serde(rename = "date_updated", skip_serializing_if = "Option::is_none")]
    pub date_updated: Option<String>,
    #[serde(rename = "uuid4", skip_serializing_if = "Option::is_none")]
    pub uuid4: Option<String>,
    #[serde(rename = "rating_score", skip_serializing_if = "Option::is_none")]
    pub rating_score: Option<String>,
    #[serde(rename = "is_pinned", skip_serializing_if = "Option::is_none")]
    pub is_pinned: Option<String>,
    #[serde(rename = "is_deprecated", skip_serializing_if = "Option::is_none")]
    pub is_deprecated: Option<String>,
    #[serde(rename = "has_nsfw_content", skip_serializing_if = "Option::is_none")]
    pub has_nsfw_content: Option<bool>,
    #[serde(rename = "categories", skip_serializing_if = "Option::is_none")]
    pub categories: Option<String>,
    #[serde(rename = "versions", skip_serializing_if = "Option::is_none")]
    pub versions: Option<String>,
}

impl PackageListing {
    pub fn new() -> PackageListing {
        PackageListing {
            name: None,
            full_name: None,
            owner: None,
            package_url: None,
            donation_link: None,
            date_created: None,
            date_updated: None,
            uuid4: None,
            rating_score: None,
            is_pinned: None,
            is_deprecated: None,
            has_nsfw_content: None,
            categories: None,
            versions: None,
        }
    }
}


