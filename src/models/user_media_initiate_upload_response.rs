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
pub struct UserMediaInitiateUploadResponse {
    #[serde(rename = "user_media")]
    pub user_media: Box<crate::models::UserMedia>,
    #[serde(rename = "upload_urls")]
    pub upload_urls: Vec<crate::models::UploadPartUrl>,
}

impl UserMediaInitiateUploadResponse {
    pub fn new(user_media: crate::models::UserMedia, upload_urls: Vec<crate::models::UploadPartUrl>) -> UserMediaInitiateUploadResponse {
        UserMediaInitiateUploadResponse {
            user_media: Box::new(user_media),
            upload_urls,
        }
    }
}

