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
pub struct UploadPartUrl {
    #[serde(rename = "part_number")]
    pub part_number: i32,
    #[serde(rename = "url")]
    pub url: String,
    #[serde(rename = "offset")]
    pub offset: i32,
    #[serde(rename = "length")]
    pub length: i32,
}

impl UploadPartUrl {
    pub fn new(part_number: i32, url: String, offset: i32, length: i32) -> UploadPartUrl {
        UploadPartUrl {
            part_number,
            url,
            offset,
            length,
        }
    }
}


