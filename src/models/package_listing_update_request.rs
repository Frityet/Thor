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
pub struct PackageListingUpdateRequest {
    #[serde(rename = "categories")]
    pub categories: Vec<String>,
}

impl PackageListingUpdateRequest {
    pub fn new(categories: Vec<String>) -> PackageListingUpdateRequest {
        PackageListingUpdateRequest {
            categories,
        }
    }
}


