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
pub struct Wiki {
    #[serde(rename = "id")]
    pub id: String,
    #[serde(rename = "title")]
    pub title: String,
    #[serde(rename = "slug")]
    pub slug: String,
    #[serde(rename = "datetime_created")]
    pub datetime_created: String,
    #[serde(rename = "datetime_updated")]
    pub datetime_updated: String,
    #[serde(rename = "pages")]
    pub pages: Vec<crate::models::WikiPageIndex>,
}

impl Wiki {
    pub fn new(id: String, title: String, slug: String, datetime_created: String, datetime_updated: String, pages: Vec<crate::models::WikiPageIndex>) -> Wiki {
        Wiki {
            id,
            title,
            slug,
            datetime_created,
            datetime_updated,
            pages,
        }
    }
}


