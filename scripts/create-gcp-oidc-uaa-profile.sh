# (1) create an .env file and supply the following values outside of this repository (do NOT check it in)

# EMAIL_DOMAIN=<CHANGE_ME>                                 // i.e. domain.com
# GCP_OAUTH_CLIENT_ID=<CHANGE_ME>                          // see for more info: https://developers.google.com/identity/protocols/oauth2
# GCP_OAUTH_CLIENT_SECRET=<CHANGE_ME>                      // see for more info: https://developers.google.com/identity/protocols/oauth2
# UAA_LOGIN_URI                                            // https://api.pks.domain.com:8443

# (2) in your terminal: source .env

# (3) execute this script: 

# source create-gcp-oidc-uaa-profile.sh

cat > ocid-profile.json << EOF
{
    "type": "oidc1.0",
    "config": {
	"enforceDomains": true,
        "emailDomain": ["${EMAIL_DOMAIN}"],
        "providerDescription": null,
        "attributeMappings": {
            "user_name": "email",
            "email_verified": "emailVerified",
            "external_groups": [
                "roles"
            ],
            "user.attribute.department": "department",
            "phone_number": "telephone",
            "given_name": "first_name",
            "family_name": "last_name",
            "email": "emailAddress"
        },
        "addShadowUserOnLogin": true,
        "storeCustomAttributes": true,
        "authUrl": "https://accounts.google.com/o/oauth2/v2/auth",
        "tokenUrl": "https://www.googleapis.com/oauth2/v4/token",
        "tokenKeyUrl": "https://www.googleapis.com/oauth2/v3/certs",
        "issuer": "https://accounts.google.com",
        "linkText": "Log into Google",
        "showLinkText": true,
        "clientAuthInBody": false,
        "skipSslValidation": false,
        "relyingPartyId": "${GCP_OAUTH_CLIENT_ID}",
        "relyingPartySecret": "${GCP_OAUTH_CLIENT_SECRET}",
        "redirectUrl": "${UAA_LOGIN_URI}",
        "scopes": [
            "openid",
            "email",
            "profile"
        ],
        "responseType": "code"
    },
    "originKey": "google",
    "name": "UAA Oauth Identity Provider[google]",
    "active": true
}
EOF