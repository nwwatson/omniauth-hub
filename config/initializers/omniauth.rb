# Suppress warnings for re-assigning a constant
v, $VERBOSE = $VERBOSE, nil

# Disable SSL verification
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# Enable organization support
#OmniAuth::Hub::ENABLE_ORGANIZATIONS = ENV["OMNIAUTH_HUB_ENABLE_ORGANIZATIONS"] != "0"

# Override the default Hub Hub provider URL (if specified)
#OmniAuth::Hub::PROVIDER_URL = ENV["OMNIAUTH_HUB_PROVIDER_URL"] if ENV["OMNIAUTH_HUB_PROVIDER_URL"]

# Return to original verbosity for warnings
$VERBOSE = v
