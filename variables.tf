variable "comprehend_document_classifiers" {
  description = <<EOT
Map of comprehend_document_classifiers, attributes below
Required:
    - data_access_role_arn
    - language_code
    - name
    - input_data_config (block):
        - augmented_manifests (optional, block):
            - annotation_data_s3_uri (optional)
            - attribute_names (required)
            - document_type (optional)
            - s3_uri (required)
            - source_documents_s3_uri (optional)
            - split (optional)
        - data_format (optional)
        - label_delimiter (optional)
        - s3_uri (optional)
        - test_s3_uri (optional)
Optional:
    - mode
    - model_kms_key_id
    - region
    - tags
    - tags_all
    - version_name
    - version_name_prefix
    - volume_kms_key_id
    - output_data_config (block):
        - kms_key_id (optional)
        - s3_uri (required)
    - vpc_config (block):
        - security_group_ids (required)
        - subnets (required)
EOT

  type = map(object({
    data_access_role_arn = string
    language_code        = string
    name                 = string
    mode                 = optional(string)
    model_kms_key_id     = optional(string)
    region               = optional(string)
    tags                 = optional(map(string))
    tags_all             = optional(map(string))
    version_name         = optional(string)
    version_name_prefix  = optional(string)
    volume_kms_key_id    = optional(string)
    input_data_config = object({
      augmented_manifests = optional(list(object({
        annotation_data_s3_uri  = optional(string)
        attribute_names         = list(string)
        document_type           = optional(string)
        s3_uri                  = string
        source_documents_s3_uri = optional(string)
        split                   = optional(string)
      })))
      data_format     = optional(string)
      label_delimiter = optional(string)
      s3_uri          = optional(string)
      test_s3_uri     = optional(string)
    })
    output_data_config = optional(object({
      kms_key_id = optional(string)
      s3_uri     = string
    }))
    vpc_config = optional(object({
      security_group_ids = set(string)
      subnets            = set(string)
    }))
  }))
  # Note: 12 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

