Pod::Spec.new do |s|
    s.name              = "BSNetworking"
    s.version           = "1.0.0"
    s.summary           = "Networking library."
    s.homepage          = "http://gitlab/ios/networking"
    s.license           = "LICENSE"
    s.author            = { "Sofien Benharchache" => "sofien@benharchache.com" }
    s.source            = { :git => "http://Gitlab/ios/BSNetworking.git", :tag => s.version }
    s.social_media_url  = "https://twitter.com/Sofien"
    
    s.platform      = :ios, '10.0'
    s.requires_arc  = true
    s.ios.deployment_target = '10.0'

    
    s.source_files = 'src/Encoding/*.swift', 'src/Service/*.swift'
    #s.public_header_files = 'src/Encoding/*.swift', 'src/Service/*.swift'
    #s.private_header_files = 'src/Encoding/*.swift', 'src/Service/*.swift'
    #s.prefix_header_file = 'BSNetworking.pch'

    #s.libraries = 'xml2', 'z'
    #s.ios.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2 ${PODS_ROOT}/Headers/Private/BSNetworking",
    #                   "GCC_PREPROCESSOR_DEFINITIONS" => "BSNETWORKING_LIB" }
    
end
