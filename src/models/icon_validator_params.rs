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
pub struct IconValidatorParams {
    #[serde(rename = "icon_data")]
    pub icon_data: String,
}

impl IconValidatorParams {
    pub fn new(icon_data: String) -> IconValidatorParams {
        IconValidatorParams {
            icon_data,
        }
    }
}


