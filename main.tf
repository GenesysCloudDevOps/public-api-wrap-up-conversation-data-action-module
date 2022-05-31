resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "additionalProperties" = true,
        "properties" = {
            "conversationId" = {
                "type" = "string"
            },
            "notes" = {
                "type" = "string"
            },
            "participantId" = {
                "type" = "string"
            },
            "wrapUpCodeId" = {
                "type" = "string"
            }
        },
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\n   \"wrapup\": {\n      \"code\": \"$!{input.wrapUpCodeId}\",\n      \"notes\": \"$!{input.notes}\",\n      \"durationSeconds\": 0\n   },\n   \"state\": \"disconnected\"\n}"
        request_type         = "PATCH"
        request_url_template = "/api/v2/conversations/$${input.conversationId}/participants/$${input.participantId}"
    }

    config_response {
        success_template = "$${rawResult}"
    }
}