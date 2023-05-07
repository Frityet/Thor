return {
  ["arg 1"] = {
    basePath = "/",
    consumes = {
      "application/json"
    },
    definitions = {
      AvailableCommunity = {
        properties = {
          categories = {
            items = {
              ["$ref"] = "#/definitions/PackageCategory"
            },
            type = "array"
          },
          community = {
            ["$ref"] = "#/definitions/Community"
          },
          url = {
            minLength = 1,
            title = "Url",
            type = "string"
          }
        },
        required = {
          "community",
          "categories",
          "url"
        },
        type = "object"
      },
      Community = {
        properties = {
          discord_url = {
            maxLength = 512,
            title = "Discord url",
            type = "string",
            ["x-nullable"] = true
          },
          identifier = {
            maxLength = 256,
            minLength = 1,
            title = "Identifier",
            type = "string"
          },
          name = {
            maxLength = 256,
            minLength = 1,
            title = "Name",
            type = "string"
          },
          require_package_listing_approval = {
            title = "Require package listing approval",
            type = "boolean"
          },
          wiki_url = {
            maxLength = 512,
            title = "Wiki url",
            type = "string",
            ["x-nullable"] = true
          }
        },
        required = {
          "identifier",
          "name"
        },
        type = "object"
      },
      CommunityCard = {
        properties = {
          bg_image_src = {
            minLength = 1,
            title = "Bg image src",
            type = "string",
            ["x-nullable"] = true
          },
          download_count = {
            minimum = 0,
            title = "Download count",
            type = "integer"
          },
          identifier = {
            maxLength = 256,
            minLength = 1,
            title = "Identifier",
            type = "string"
          },
          name = {
            maxLength = 256,
            minLength = 1,
            title = "Name",
            type = "string"
          },
          package_count = {
            minimum = 0,
            title = "Package count",
            type = "integer"
          }
        },
        required = {
          "bg_image_src",
          "download_count",
          "identifier",
          "name",
          "package_count"
        },
        type = "object"
      },
      CommunityPackageList = {
        properties = {
          bg_image_src = {
            minLength = 1,
            title = "Bg image src",
            type = "string",
            ["x-nullable"] = true
          },
          categories = {
            items = {
              ["$ref"] = "#/definitions/PackageCategory"
            },
            type = "array"
          },
          community_name = {
            maxLength = 256,
            minLength = 1,
            title = "Community name",
            type = "string"
          },
          has_more_pages = {
            title = "Has more pages",
            type = "boolean"
          },
          packages = {
            items = {
              ["$ref"] = "#/definitions/PackageCard"
            },
            type = "array"
          }
        },
        required = {
          "bg_image_src",
          "categories",
          "community_name",
          "has_more_pages",
          "packages"
        },
        type = "object"
      },
      CompletedPart = {
        properties = {
          ETag = {
            minLength = 1,
            title = "Etag",
            type = "string"
          },
          PartNumber = {
            title = "Partnumber",
            type = "integer"
          }
        },
        required = {
          "ETag",
          "PartNumber"
        },
        type = "object"
      },
      FrontPageContent = {
        properties = {
          communities = {
            items = {
              ["$ref"] = "#/definitions/CommunityCard"
            },
            type = "array"
          },
          download_count = {
            minimum = 0,
            title = "Download count",
            type = "integer"
          },
          package_count = {
            minimum = 0,
            title = "Package count",
            type = "integer"
          }
        },
        required = {
          "communities",
          "download_count",
          "package_count"
        },
        type = "object"
      },
      IconValidatorParams = {
        properties = {
          icon_data = {
            minLength = 1,
            title = "Icon data",
            type = "string"
          }
        },
        required = {
          "icon_data"
        },
        type = "object"
      },
      LegacyProfileCreateResponse = {
        properties = {
          key = {
            minLength = 1,
            title = "Key",
            type = "string"
          }
        },
        required = {
          "key"
        },
        type = "object"
      },
      ManifestV1ValidatorParams = {
        properties = {
          manifest_data = {
            minLength = 1,
            title = "Manifest data",
            type = "string"
          },
          namespace = {
            title = "Namespace",
            type = "string"
          }
        },
        required = {
          "namespace",
          "manifest_data"
        },
        type = "object"
      },
      MarkdownResponse = {
        properties = {
          markdown = {
            minLength = 1,
            title = "Markdown",
            type = "string",
            ["x-nullable"] = true
          }
        },
        required = {
          "markdown"
        },
        type = "object"
      },
      OwLoginRequestBody = {
        properties = {
          jwt = {
            minLength = 1,
            title = "Authorization token",
            type = "string"
          }
        },
        required = {
          "jwt"
        },
        type = "object"
      },
      OwLoginResponseBody = {
        properties = {
          session_id = {
            minLength = 1,
            title = "Session id",
            type = "string"
          },
          username = {
            minLength = 1,
            title = "Username",
            type = "string"
          }
        },
        required = {
          "session_id",
          "username"
        },
        type = "object"
      },
      PackageCard = {
        properties = {
          categories = {
            items = {
              ["$ref"] = "#/definitions/PackageCategory"
            },
            type = "array"
          },
          community_identifier = {
            maxLength = 256,
            minLength = 1,
            title = "Community identifier",
            type = "string"
          },
          community_name = {
            maxLength = 256,
            minLength = 1,
            title = "Community name",
            type = "string"
          },
          description = {
            maxLength = 256,
            minLength = 1,
            title = "Description",
            type = "string"
          },
          download_count = {
            minimum = 0,
            title = "Download count",
            type = "integer"
          },
          image_src = {
            minLength = 1,
            title = "Image src",
            type = "string",
            ["x-nullable"] = true
          },
          is_deprecated = {
            title = "Is deprecated",
            type = "boolean"
          },
          is_nsfw = {
            title = "Is nsfw",
            type = "boolean"
          },
          is_pinned = {
            title = "Is pinned",
            type = "boolean"
          },
          last_updated = {
            format = "date-time",
            title = "Last updated",
            type = "string"
          },
          namespace = {
            maxLength = 64,
            minLength = 1,
            title = "Namespace",
            type = "string"
          },
          package_name = {
            maxLength = 128,
            minLength = 1,
            title = "Package name",
            type = "string"
          },
          rating_score = {
            minimum = 0,
            title = "Rating score",
            type = "integer"
          },
          team_name = {
            maxLength = 64,
            minLength = 1,
            title = "Team name",
            type = "string"
          }
        },
        required = {
          "categories",
          "community_identifier",
          "community_name",
          "description",
          "download_count",
          "image_src",
          "is_deprecated",
          "is_nsfw",
          "is_pinned",
          "last_updated",
          "namespace",
          "package_name",
          "rating_score",
          "team_name"
        },
        type = "object"
      },
      PackageCategory = {
        properties = {
          name = {
            maxLength = 512,
            minLength = 1,
            title = "Name",
            type = "string"
          },
          slug = {
            format = "slug",
            maxLength = 50,
            minLength = 1,
            pattern = "^[-a-zA-Z0-9_]+$",
            title = "Slug",
            type = "string"
          }
        },
        required = {
          "name",
          "slug"
        },
        type = "object"
      },
      PackageCategoryExperimental = {
        properties = {
          name = {
            minLength = 1,
            title = "Name",
            type = "string"
          },
          slug = {
            format = "slug",
            minLength = 1,
            pattern = "^[-a-zA-Z0-9_]+$",
            title = "Slug",
            type = "string"
          }
        },
        required = {
          "name",
          "slug"
        },
        type = "object"
      },
      PackageDependency = {
        properties = {
          community_identifier = {
            maxLength = 256,
            minLength = 1,
            title = "Community identifier",
            type = "string",
            ["x-nullable"] = true
          },
          community_name = {
            maxLength = 256,
            minLength = 1,
            title = "Community name",
            type = "string",
            ["x-nullable"] = true
          },
          description = {
            maxLength = 256,
            minLength = 1,
            title = "Description",
            type = "string"
          },
          image_src = {
            minLength = 1,
            title = "Image src",
            type = "string",
            ["x-nullable"] = true
          },
          namespace = {
            maxLength = 64,
            minLength = 1,
            title = "Namespace",
            type = "string"
          },
          package_name = {
            maxLength = 128,
            minLength = 1,
            title = "Package name",
            type = "string"
          },
          version_number = {
            maxLength = 16,
            minLength = 1,
            title = "Version number",
            type = "string"
          }
        },
        required = {
          "community_identifier",
          "community_name",
          "description",
          "image_src",
          "namespace",
          "package_name",
          "version_number"
        },
        type = "object"
      },
      PackageDetailViewContent = {
        properties = {
          bg_image_src = {
            minLength = 1,
            title = "Bg image src",
            type = "string",
            ["x-nullable"] = true
          },
          categories = {
            items = {
              ["$ref"] = "#/definitions/PackageCategory"
            },
            type = "array"
          },
          community_identifier = {
            maxLength = 256,
            minLength = 1,
            title = "Community identifier",
            type = "string"
          },
          community_name = {
            maxLength = 256,
            minLength = 1,
            title = "Community name",
            type = "string"
          },
          dependant_count = {
            minimum = 0,
            title = "Dependant count",
            type = "integer"
          },
          dependencies = {
            items = {
              ["$ref"] = "#/definitions/PackageDependency"
            },
            type = "array"
          },
          dependency_string = {
            maxLength = 210,
            minLength = 1,
            title = "Dependency string",
            type = "string"
          },
          description = {
            maxLength = 256,
            minLength = 1,
            title = "Description",
            type = "string"
          },
          download_count = {
            minimum = 0,
            title = "Download count",
            type = "integer"
          },
          download_url = {
            minLength = 1,
            title = "Download url",
            type = "string"
          },
          image_src = {
            minLength = 1,
            title = "Image src",
            type = "string",
            ["x-nullable"] = true
          },
          install_url = {
            minLength = 1,
            title = "Install url",
            type = "string"
          },
          last_updated = {
            format = "date-time",
            title = "Last updated",
            type = "string"
          },
          markdown = {
            minLength = 1,
            title = "Markdown",
            type = "string"
          },
          namespace = {
            maxLength = 64,
            minLength = 1,
            title = "Namespace",
            type = "string"
          },
          package_name = {
            maxLength = 128,
            minLength = 1,
            title = "Package name",
            type = "string"
          },
          rating_score = {
            minimum = 0,
            title = "Rating score",
            type = "integer"
          },
          team_name = {
            maxLength = 64,
            minLength = 1,
            title = "Team name",
            type = "string"
          },
          versions = {
            items = {
              ["$ref"] = "#/definitions/PackageVersion"
            },
            type = "array"
          },
          website = {
            maxLength = 1024,
            minLength = 1,
            title = "Website",
            type = "string"
          }
        },
        required = {
          "bg_image_src",
          "categories",
          "community_identifier",
          "community_name",
          "dependant_count",
          "dependencies",
          "dependency_string",
          "description",
          "download_count",
          "download_url",
          "image_src",
          "install_url",
          "last_updated",
          "markdown",
          "namespace",
          "package_name",
          "rating_score",
          "team_name",
          "versions",
          "website"
        },
        type = "object"
      },
      PackageExperimental = {
        properties = {
          community_listings = {
            items = {
              ["$ref"] = "#/definitions/PackageListingExperimental"
            },
            type = "array"
          },
          date_created = {
            format = "date-time",
            readOnly = true,
            title = "Date created",
            type = "string"
          },
          date_updated = {
            format = "date-time",
            readOnly = true,
            title = "Date updated",
            type = "string"
          },
          full_name = {
            readOnly = true,
            title = "Full name",
            type = "string"
          },
          is_deprecated = {
            title = "Is deprecated",
            type = "boolean"
          },
          is_pinned = {
            title = "Is pinned",
            type = "boolean"
          },
          latest = {
            ["$ref"] = "#/definitions/PackageVersionExperimental"
          },
          name = {
            maxLength = 128,
            minLength = 1,
            title = "Name",
            type = "string"
          },
          namespace = {
            readOnly = true,
            title = "Namespace",
            type = "string"
          },
          owner = {
            readOnly = true,
            title = "Owner",
            type = "string"
          },
          package_url = {
            readOnly = true,
            title = "Package url",
            type = "string"
          },
          rating_score = {
            readOnly = true,
            title = "Rating score",
            type = "string"
          },
          total_downloads = {
            readOnly = true,
            title = "Total downloads",
            type = "string"
          }
        },
        required = {
          "name",
          "latest",
          "community_listings"
        },
        type = "object"
      },
      PackageListing = {
        properties = {
          categories = {
            readOnly = true,
            title = "Categories",
            type = "string"
          },
          date_created = {
            readOnly = true,
            title = "Date created",
            type = "string"
          },
          date_updated = {
            readOnly = true,
            title = "Date updated",
            type = "string"
          },
          donation_link = {
            readOnly = true,
            title = "Donation link",
            type = "string"
          },
          full_name = {
            readOnly = true,
            title = "Full name",
            type = "string"
          },
          has_nsfw_content = {
            title = "Has nsfw content",
            type = "boolean"
          },
          is_deprecated = {
            readOnly = true,
            title = "Is deprecated",
            type = "string"
          },
          is_pinned = {
            readOnly = true,
            title = "Is pinned",
            type = "string"
          },
          name = {
            readOnly = true,
            title = "Name",
            type = "string"
          },
          owner = {
            readOnly = true,
            title = "Owner",
            type = "string"
          },
          package_url = {
            readOnly = true,
            title = "Package url",
            type = "string"
          },
          rating_score = {
            readOnly = true,
            title = "Rating score",
            type = "string"
          },
          uuid4 = {
            readOnly = true,
            title = "Uuid4",
            type = "string"
          },
          versions = {
            readOnly = true,
            title = "Versions",
            type = "string"
          }
        },
        type = "object"
      },
      PackageListingExperimental = {
        properties = {
          categories = {
            readOnly = true,
            title = "Categories",
            type = "string"
          },
          community = {
            readOnly = true,
            title = "Community",
            type = "string"
          },
          has_nsfw_content = {
            title = "Has nsfw content",
            type = "boolean"
          },
          review_status = {
            enum = {
              "unreviewed",
              "approved",
              "rejected"
            },
            title = "Review status",
            type = "string"
          }
        },
        type = "object"
      },
      PackageListingUpdateRequest = {
        properties = {
          categories = {
            items = {
              type = "string"
            },
            type = "array"
          }
        },
        required = {
          "categories"
        },
        type = "object"
      },
      PackageListingUpdateResponse = {
        properties = {
          categories = {
            items = {
              ["$ref"] = "#/definitions/PackageCategoryExperimental"
            },
            type = "array"
          }
        },
        required = {
          "categories"
        },
        type = "object"
      },
      PackageSubmissionMetadata = {
        properties = {
          author_name = {
            title = "Author name",
            type = "string"
          },
          categories = {
            items = {
              type = "string"
            },
            type = "array"
          },
          communities = {
            items = {
              type = "string"
            },
            type = "array"
          },
          community_categories = {
            additionalProperties = {
              items = {
                minLength = 1,
                type = "string"
              },
              type = "array"
            },
            title = "Community categories",
            type = "object"
          },
          has_nsfw_content = {
            title = "Has nsfw content",
            type = "boolean"
          },
          upload_uuid = {
            format = "uuid",
            title = "Upload uuid",
            type = "string"
          }
        },
        required = {
          "author_name",
          "communities",
          "has_nsfw_content",
          "upload_uuid"
        },
        type = "object"
      },
      PackageSubmissionResult = {
        properties = {
          available_communities = {
            items = {
              ["$ref"] = "#/definitions/AvailableCommunity"
            },
            type = "array"
          },
          package_version = {
            ["$ref"] = "#/definitions/PackageVersionExperimental"
          }
        },
        required = {
          "package_version",
          "available_communities"
        },
        type = "object"
      },
      PackageVersion = {
        properties = {
          date_created = {
            format = "date-time",
            title = "Date created",
            type = "string"
          },
          download_count = {
            minimum = 0,
            title = "Download count",
            type = "integer"
          },
          download_url = {
            minLength = 1,
            title = "Download url",
            type = "string"
          },
          install_url = {
            minLength = 1,
            title = "Install url",
            type = "string"
          },
          version_number = {
            maxLength = 16,
            minLength = 1,
            title = "Version number",
            type = "string"
          }
        },
        required = {
          "date_created",
          "download_count",
          "download_url",
          "install_url",
          "version_number"
        },
        type = "object"
      },
      PackageVersionExperimental = {
        properties = {
          date_created = {
            format = "date-time",
            readOnly = true,
            title = "Date created",
            type = "string"
          },
          dependencies = {
            readOnly = true,
            title = "Dependencies",
            type = "string"
          },
          description = {
            maxLength = 256,
            minLength = 1,
            title = "Description",
            type = "string"
          },
          download_url = {
            readOnly = true,
            title = "Download url",
            type = "string"
          },
          downloads = {
            maximum = 2147483647,
            minimum = 0,
            title = "Downloads",
            type = "integer"
          },
          full_name = {
            readOnly = true,
            title = "Full name",
            type = "string"
          },
          icon = {
            format = "uri",
            readOnly = true,
            title = "Icon",
            type = "string"
          },
          is_active = {
            title = "Is active",
            type = "boolean"
          },
          name = {
            maxLength = 128,
            minLength = 1,
            title = "Name",
            type = "string"
          },
          namespace = {
            readOnly = true,
            title = "Namespace",
            type = "string"
          },
          version_number = {
            maxLength = 16,
            minLength = 1,
            title = "Version number",
            type = "string"
          },
          website_url = {
            maxLength = 1024,
            minLength = 1,
            title = "Website url",
            type = "string"
          }
        },
        required = {
          "name",
          "version_number",
          "description",
          "website_url"
        },
        type = "object"
      },
      PackageWiki = {
        properties = {
          name = {
            minLength = 1,
            title = "Name",
            type = "string"
          },
          namespace = {
            minLength = 1,
            title = "Namespace",
            type = "string"
          },
          wiki = {
            ["$ref"] = "#/definitions/Wiki"
          }
        },
        required = {
          "namespace",
          "name",
          "wiki"
        },
        type = "object"
      },
      PackageWikiListResponse = {
        properties = {
          cursor = {
            format = "date-time",
            title = "Cursor",
            type = "string"
          },
          has_more = {
            title = "Has more",
            type = "boolean"
          },
          results = {
            items = {
              ["$ref"] = "#/definitions/PackageWiki"
            },
            type = "array"
          }
        },
        required = {
          "results",
          "cursor",
          "has_more"
        },
        type = "object"
      },
      ReadmeValidatorParams = {
        properties = {
          readme_data = {
            minLength = 1,
            title = "Readme data",
            type = "string"
          }
        },
        required = {
          "readme_data"
        },
        type = "object"
      },
      RenderMarkdownParams = {
        properties = {
          markdown = {
            maxLength = 100000,
            minLength = 1,
            title = "Markdown",
            type = "string"
          }
        },
        required = {
          "markdown"
        },
        type = "object"
      },
      RenderMarkdownResponse = {
        properties = {
          html = {
            minLength = 1,
            title = "Html",
            type = "string"
          }
        },
        required = {
          "html"
        },
        type = "object"
      },
      RequestBody = {
        properties = {
          code = {
            minLength = 1,
            title = "Authorization code received from the provider when authentication flow was initiated on the client",
            type = "string"
          },
          redirect_uri = {
            minLength = 1,
            title = "Redirect URI used when the authentication flow was initiated on client",
            type = "string"
          }
        },
        required = {
          "code",
          "redirect_uri"
        },
        type = "object"
      },
      ResponseBody = {
        properties = {
          email = {
            minLength = 1,
            title = "Email",
            type = "string",
            ["x-nullable"] = true
          },
          session_id = {
            minLength = 1,
            title = "Session id",
            type = "string"
          },
          username = {
            minLength = 1,
            title = "Username",
            type = "string"
          }
        },
        required = {
          "email",
          "session_id",
          "username"
        },
        type = "object"
      },
      UploadPartUrl = {
        properties = {
          length = {
            title = "Length",
            type = "integer"
          },
          offset = {
            title = "Offset",
            type = "integer"
          },
          part_number = {
            title = "Part number",
            type = "integer"
          },
          url = {
            format = "uri",
            minLength = 1,
            title = "Url",
            type = "string"
          }
        },
        required = {
          "part_number",
          "url",
          "offset",
          "length"
        },
        type = "object"
      },
      UserMedia = {
        properties = {
          datetime_created = {
            format = "date-time",
            readOnly = true,
            title = "Datetime created",
            type = "string"
          },
          expiry = {
            format = "date-time",
            title = "Expiry",
            type = "string",
            ["x-nullable"] = true
          },
          filename = {
            maxLength = 1024,
            minLength = 1,
            title = "Filename",
            type = "string"
          },
          size = {
            maximum = 2147483647,
            minimum = 0,
            title = "Size",
            type = "integer"
          },
          status = {
            enum = {
              "initial",
              "upload_created",
              "upload_error",
              "upload_complete",
              "upload_aborted"
            },
            title = "Status",
            type = "string"
          },
          uuid = {
            format = "uuid",
            title = "Uuid",
            type = "string"
          }
        },
        required = {
          "filename",
          "size"
        },
        type = "object"
      },
      UserMediaFinishUploadParams = {
        properties = {
          parts = {
            items = {
              ["$ref"] = "#/definitions/CompletedPart"
            },
            type = "array"
          }
        },
        required = {
          "parts"
        },
        type = "object"
      },
      UserMediaInitiateUploadParams = {
        properties = {
          file_size_bytes = {
            minimum = 1,
            title = "File size bytes",
            type = "integer"
          },
          filename = {
            minLength = 1,
            title = "Filename",
            type = "string"
          }
        },
        required = {
          "filename",
          "file_size_bytes"
        },
        type = "object"
      },
      UserMediaInitiateUploadResponse = {
        properties = {
          upload_urls = {
            items = {
              ["$ref"] = "#/definitions/UploadPartUrl"
            },
            type = "array"
          },
          user_media = {
            ["$ref"] = "#/definitions/UserMedia"
          }
        },
        required = {
          "user_media",
          "upload_urls"
        },
        type = "object"
      },
      ValidatorResponse = {
        properties = {
          success = {
            title = "Success",
            type = "boolean"
          }
        },
        required = {
          "success"
        },
        type = "object"
      },
      Wiki = {
        properties = {
          datetime_created = {
            format = "date-time",
            title = "Datetime created",
            type = "string"
          },
          datetime_updated = {
            format = "date-time",
            title = "Datetime updated",
            type = "string"
          },
          id = {
            minLength = 1,
            title = "Id",
            type = "string"
          },
          pages = {
            items = {
              ["$ref"] = "#/definitions/WikiPageIndex"
            },
            type = "array"
          },
          slug = {
            minLength = 1,
            title = "Slug",
            type = "string"
          },
          title = {
            minLength = 1,
            title = "Title",
            type = "string"
          }
        },
        required = {
          "id",
          "title",
          "slug",
          "datetime_created",
          "datetime_updated",
          "pages"
        },
        type = "object"
      },
      WikiPage = {
        properties = {
          datetime_created = {
            format = "date-time",
            title = "Datetime created",
            type = "string"
          },
          datetime_updated = {
            format = "date-time",
            title = "Datetime updated",
            type = "string"
          },
          id = {
            minLength = 1,
            title = "Id",
            type = "string"
          },
          markdown_content = {
            minLength = 1,
            title = "Markdown content",
            type = "string"
          },
          slug = {
            minLength = 1,
            title = "Slug",
            type = "string"
          },
          title = {
            maxLength = 512,
            minLength = 1,
            title = "Title",
            type = "string"
          }
        },
        required = {
          "id",
          "title",
          "slug",
          "datetime_created",
          "datetime_updated",
          "markdown_content"
        },
        type = "object"
      },
      WikiPageDelete = {
        properties = {
          id = {
            minLength = 1,
            title = "Id",
            type = "string"
          }
        },
        required = {
          "id"
        },
        type = "object"
      },
      WikiPageIndex = {
        properties = {
          datetime_created = {
            format = "date-time",
            title = "Datetime created",
            type = "string"
          },
          datetime_updated = {
            format = "date-time",
            title = "Datetime updated",
            type = "string"
          },
          id = {
            minLength = 1,
            title = "Id",
            type = "string"
          },
          slug = {
            minLength = 1,
            title = "Slug",
            type = "string"
          },
          title = {
            maxLength = 512,
            minLength = 1,
            title = "Title",
            type = "string"
          }
        },
        required = {
          "id",
          "title",
          "slug",
          "datetime_created",
          "datetime_updated"
        },
        type = "object"
      },
      WikiPageUpsert = {
        properties = {
          id = {
            minLength = 1,
            title = "Id",
            type = "string"
          },
          markdown_content = {
            maxLength = 100000,
            minLength = 1,
            title = "Markdown content",
            type = "string"
          },
          title = {
            maxLength = 512,
            minLength = 1,
            title = "Title",
            type = "string"
          }
        },
        required = {
          "title",
          "markdown_content"
        },
        type = "object"
      }
    },
    host = "thunderstore.io",
    info = {
      contact = {
        name = "Mythic#0001",
        url = "https://discord.gg/UWpWhjZken"
      },
      description = "Schema is automatically generated and not completely accurate.",
      title = "Thunderstore API",
      version = "v1"
    },
    paths = {
      ["/api/experimental/auth/complete/{provider}/"] = {
        parameters = {
          {
            ["in"] = "path",
            name = "provider",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "Complete OAuth login process initiated by a client.",
          operationId = "experimental.auth.complete",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/RequestBody"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/ResponseBody"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/auth/delete/"] = {
        parameters = {
        },
        post = {
          description = [[The session is provided in Authorization header and is processed by
UserSessionTokenAuthentication, which places the session key into
request.auth.]],
          operationId = "experimental.auth.delete",
          parameters = {
          },
          responses = {
            ["204"] = {
              description = ""
            }
          },
          summary = "Drop provided session from database.",
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/auth/overwolf/login/"] = {
        parameters = {
        },
        post = {
          description = [[Used by Thunderstore Mod Manager. Not to be confused with OAuth
login process triggered from a browser.]],
          operationId = "experimental.auth.overwolf.login",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/OwLoginRequestBody"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/OwLoginResponseBody"
              }
            }
          },
          summary = "Login user with information from Overwolf API using the received JWT",
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/auth/validate/"] = {
        get = {
          description = "Check that valid session key is provided in Authorization header.",
          operationId = "experimental.auth.validate",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "Session is valid"
            },
            ["401"] = {
              description = "Session key is missing, invalid, or expired"
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/community/"] = {
        get = {
          description = "",
          operationId = "api_experimental_community_list",
          parameters = {
            {
              description = "The pagination cursor value.",
              ["in"] = "query",
              name = "cursor",
              required = false,
              type = "string"
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                properties = {
                  next = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  previous = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  results = {
                    items = {
                      ["$ref"] = "#/definitions/Community"
                    },
                    type = "array"
                  }
                },
                required = {
                  "results"
                },
                type = "object"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/community/{community}/category/"] = {
        get = {
          description = "",
          operationId = "api_experimental_community_category_list",
          parameters = {
            {
              description = "The pagination cursor value.",
              ["in"] = "query",
              name = "cursor",
              required = false,
              type = "string"
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                properties = {
                  next = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  previous = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  results = {
                    items = {
                      ["$ref"] = "#/definitions/PackageCategory"
                    },
                    type = "array"
                  }
                },
                required = {
                  "results"
                },
                type = "object"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/current-community/"] = {
        get = {
          description = "Fetch the Community of the queried domain",
          operationId = "experimental.community.current",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/Community"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/current-user/"] = {
        get = {
          description = "Gets information about the current user, such as rated packages and permissions",
          operationId = "api_experimental_current-user_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = ""
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/frontend/c/{community_identifier}/p/{package_namespace}/{package_name}/"] = {
        get = {
          description = "Return details about a single Package.",
          operationId = "experimental.frontend.community.package",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageDetailViewContent"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "package_name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "package_namespace",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/frontend/c/{community_identifier}/packages/"] = {
        get = {
          description = "Return paginated list of community's packages.",
          operationId = "experimental.frontend.community.packages",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/CommunityPackageList"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/frontend/frontpage/"] = {
        get = {
          description = "Return information required to render the site's front page.",
          operationId = "experimental.frontend.frontpage",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/FrontPageContent"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/frontend/render-markdown/"] = {
        parameters = {
        },
        post = {
          description = "",
          operationId = "experimental.frontend.render-markdown",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/RenderMarkdownParams"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/RenderMarkdownResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/legacyprofile/create/"] = {
        parameters = {
        },
        post = {
          consumes = {
          },
          description = "",
          operationId = "experimental.modpacks.legacyprofile.create",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                title = "content",
                type = "file"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/LegacyProfileCreateResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/legacyprofile/get/{key}/"] = {
        get = {
          description = "",
          operationId = "experimental.modpacks.legacyprofile.retrieve",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                title = "content",
                type = "file"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "key",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/package-listing/{id}/update/"] = {
        parameters = {
          {
            description = "A unique integer value identifying this package listing.",
            ["in"] = "path",
            name = "id",
            required = true,
            type = "integer"
          }
        },
        post = {
          description = "",
          operationId = "experimental.package_listing.update",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/PackageListingUpdateRequest"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageListingUpdateResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/package/"] = {
        get = {
          description = "Lists all available packages",
          operationId = "api_experimental_package_list",
          parameters = {
            {
              description = "The pagination cursor value.",
              ["in"] = "query",
              name = "cursor",
              required = false,
              type = "string"
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                properties = {
                  next = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  previous = {
                    format = "uri",
                    type = "string",
                    ["x-nullable"] = true
                  },
                  results = {
                    items = {
                      ["$ref"] = "#/definitions/PackageExperimental"
                    },
                    type = "array"
                  }
                },
                required = {
                  "results"
                },
                type = "object"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/package/wikis/"] = {
        get = {
          description = "Fetch a bulk of package wikis at once. Supports querying by update time to accommodate local caching.",
          operationId = "experimental_package_wiki_list",
          parameters = {
            {
              format = "date-time",
              ["in"] = "query",
              name = "after",
              required = false,
              type = "string"
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageWikiListResponse"
              }
            }
          },
          summary = "List package wikis",
          tags = {
            "wiki"
          }
        },
        parameters = {
        }
      },
      ["/api/experimental/package/{namespace}/{name}/"] = {
        get = {
          description = "Get a single package",
          operationId = "experimental_package_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageExperimental"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "namespace",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/package/{namespace}/{name}/wiki/"] = {
        delete = {
          description = "Deletes a wiki page by page ID",
          operationId = "experimental_package_wiki_delete",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/WikiPageDelete"
              }
            }
          },
          responses = {
            ["204"] = {
              description = ""
            }
          },
          summary = "Delete a wiki page",
          tags = {
            "wiki"
          }
        },
        get = {
          description = "Returns an index of all the pages included in the wiki",
          operationId = "experimental_package_wiki_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/Wiki"
              }
            }
          },
          summary = "Get a list of all wiki pages",
          tags = {
            "wiki"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "namespace",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "Creates a new wiki page if a submission is made without the ID field set. If the ID field is set, the respective page will be updated instead.",
          operationId = "experimental_package_wiki_write",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/WikiPageUpsert"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/WikiPage"
              }
            }
          },
          summary = "Create or update a wiki page",
          tags = {
            "wiki"
          }
        }
      },
      ["/api/experimental/package/{namespace}/{name}/{version}/"] = {
        get = {
          description = "Get a single package version",
          operationId = "experimental_package_version_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageVersionExperimental"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "namespace",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "version",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/package/{namespace}/{name}/{version}/changelog/"] = {
        get = {
          description = "Get a package verion's changelog",
          operationId = "experimental_package_version_changelog_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/MarkdownResponse"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "namespace",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "version",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/package/{namespace}/{name}/{version}/readme/"] = {
        get = {
          description = "Get a package verion's readme",
          operationId = "experimental_package_version_readme_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/MarkdownResponse"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "name",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "namespace",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "version",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/experimental/submission/submit/"] = {
        parameters = {
        },
        post = {
          description = "Submits a pre-uploaded package by upload uuid.",
          operationId = "experimental.package.submit",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/PackageSubmissionMetadata"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageSubmissionResult"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/submission/upload/"] = {
        get = {
          consumes = {
            "multipart/form-data"
          },
          description = "Uploads a package. Requires multipart/form-data.",
          operationId = "api_experimental_submission_upload_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = ""
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        },
        post = {
          consumes = {
            "multipart/form-data"
          },
          description = "Uploads a package. Requires multipart/form-data.",
          operationId = "api_experimental_submission_upload_create",
          parameters = {
          },
          responses = {
            ["201"] = {
              description = ""
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/submission/validate/icon/"] = {
        parameters = {
        },
        post = {
          description = "Validates a package icon.",
          operationId = "experimental.submission.validate.icon",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/IconValidatorParams"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/ValidatorResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/submission/validate/manifest-v1/"] = {
        parameters = {
        },
        post = {
          description = "Validates a package manifest.",
          operationId = "experimental.submission.validate.manifest-v1",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/ManifestV1ValidatorParams"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/ValidatorResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/submission/validate/readme/"] = {
        parameters = {
        },
        post = {
          description = "Validates a package readme.",
          operationId = "experimental.submission.validate.readme",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/ReadmeValidatorParams"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/ValidatorResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/usermedia/initiate-upload/"] = {
        parameters = {
        },
        post = {
          description = "",
          operationId = "experimental.usermedia.initiate-upload",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/UserMediaInitiateUploadParams"
              }
            }
          },
          responses = {
            ["201"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/UserMediaInitiateUploadResponse"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/usermedia/{uuid}/abort-upload/"] = {
        parameters = {
          {
            description = "A UUID string identifying this user media.",
            format = "uuid",
            ["in"] = "path",
            name = "uuid",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "",
          operationId = "experimental.usermedia.abort-upload",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/UserMedia"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/usermedia/{uuid}/finish-upload/"] = {
        parameters = {
          {
            description = "A UUID string identifying this user media.",
            format = "uuid",
            ["in"] = "path",
            name = "uuid",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "",
          operationId = "experimental.usermedia.finish-upload",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/UserMediaFinishUploadParams"
              }
            }
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/UserMedia"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/api/experimental/wiki/page/{id}/"] = {
        get = {
          description = "Returns a wiki page object",
          operationId = "experimental_wiki_page_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/WikiPage"
              }
            }
          },
          summary = "Get a wiki page",
          tags = {
            "wiki"
          }
        },
        parameters = {
          {
            description = "A unique integer value identifying this wiki page.",
            ["in"] = "path",
            name = "id",
            required = true,
            type = "integer"
          }
        }
      },
      ["/api/v1/bot/deprecate-mod/"] = {
        parameters = {
        },
        post = {
          consumes = {
            "application/jwt"
          },
          description = [[* Requires JWT authentication.
* Only users with special permissions may use this action]],
          operationId = "api_v1_bot_deprecate-mod_create",
          parameters = {
          },
          responses = {
            ["201"] = {
              description = ""
            }
          },
          summary = "Deprecates a mod by it's package name",
          tags = {
            "api"
          }
        }
      },
      ["/api/v1/current-user/info/"] = {
        get = {
          description = "Gets information about the current user, such as rated packages and permissions",
          operationId = "api_v1_current-user_info_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = ""
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/v1/package/"] = {
        get = {
          description = "",
          operationId = "api_v1_package_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                items = {
                  ["$ref"] = "#/definitions/PackageListing"
                },
                type = "array"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
        }
      },
      ["/api/v1/package/{uuid4}/"] = {
        get = {
          description = "",
          operationId = "api_v1_package_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          tags = {
            "api"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "uuid4",
            required = true,
            type = "string"
          }
        }
      },
      ["/api/v1/package/{uuid4}/rate/"] = {
        parameters = {
          {
            ["in"] = "path",
            name = "uuid4",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "",
          operationId = "api_v1_package_rate",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          responses = {
            ["201"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          tags = {
            "api"
          }
        }
      },
      ["/c/{community_identifier}/api/v1/bot/deprecate-mod/"] = {
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          }
        },
        post = {
          consumes = {
            "application/jwt"
          },
          description = [[* Requires JWT authentication.
* Only users with special permissions may use this action]],
          operationId = "c_api_v1_bot_deprecate-mod_create",
          parameters = {
          },
          responses = {
            ["201"] = {
              description = ""
            }
          },
          summary = "Deprecates a mod by it's package name",
          tags = {
            "c"
          }
        }
      },
      ["/c/{community_identifier}/api/v1/current-user/info/"] = {
        get = {
          description = "Gets information about the current user, such as rated packages and permissions",
          operationId = "c_api_v1_current-user_info_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = ""
            }
          },
          tags = {
            "c"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          }
        }
      },
      ["/c/{community_identifier}/api/v1/package/"] = {
        get = {
          description = "",
          operationId = "c_api_v1_package_list",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                items = {
                  ["$ref"] = "#/definitions/PackageListing"
                },
                type = "array"
              }
            }
          },
          tags = {
            "c"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          }
        }
      },
      ["/c/{community_identifier}/api/v1/package/{uuid4}/"] = {
        get = {
          description = "",
          operationId = "c_api_v1_package_read",
          parameters = {
          },
          responses = {
            ["200"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          tags = {
            "c"
          }
        },
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "uuid4",
            required = true,
            type = "string"
          }
        }
      },
      ["/c/{community_identifier}/api/v1/package/{uuid4}/rate/"] = {
        parameters = {
          {
            ["in"] = "path",
            name = "community_identifier",
            required = true,
            type = "string"
          },
          {
            ["in"] = "path",
            name = "uuid4",
            required = true,
            type = "string"
          }
        },
        post = {
          description = "",
          operationId = "c_api_v1_package_rate",
          parameters = {
            {
              ["in"] = "body",
              name = "data",
              required = true,
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          responses = {
            ["201"] = {
              description = "",
              schema = {
                ["$ref"] = "#/definitions/PackageListing"
              }
            }
          },
          tags = {
            "c"
          }
        }
      }
    },
    produces = {
      "application/json"
    },
    schemes = {
      "https"
    },
    security = {
      {
        Basic = {
        }
      }
    },
    securityDefinitions = {
      Basic = {
        type = "basic"
      }
    },
    swagger = "2.0"
  }
}
